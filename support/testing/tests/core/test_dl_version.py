import infra
import subprocess
import json

class DlVersionTest(infra.basetest.BRConfigTest):
    config = ""
    br2_external = [infra.filepath("tests/core/dl-version-br2-external")]

    def get_vars(self, var):
        cmd = ["make", "--no-print-directory", "-C", self.b.builddir,
               "VARS=%s%%" % var, "printvars"]
        lines = subprocess.check_output(cmd).splitlines()
        return dict([str(x, "utf-8").split("=") for x in lines])

    def get_json_vars(self):
        cmd = ["make", "--no-print-directory", "-C", self.b.builddir,
               "show-vars"]
        output = subprocess.check_output(cmd)
        return json.loads(output)

    def test_pkg1(self):
        json = self.get_json_vars()
        self.assertEqual(json["PKG1_VERSION"]["expanded"], "foo_123")
        self.assertEqual(json["PKG1_DL_VERSION_FINAL"]["expanded"], "foo/123")
        self.assertNotIn("HOST_PKG1_VERSION", json)
        self.assertNotIn("HOST_PKG1_DL_VERSION_FINAL", json)

    def test_pkg2(self):
        json = self.get_json_vars()
        self.assertEqual(json["PKG2_VERSION"]["expanded"], "foo_123")
        self.assertEqual(json["PKG2_DL_VERSION_FINAL"]["expanded"], "foo/123")
        self.assertEqual(json["HOST_PKG2_VERSION"]["expanded"], "foo_123")
        self.assertEqual(json["HOST_PKG2_DL_VERSION_FINAL"]["expanded"], "foo/123")

    def test_pkg3(self):
        json = self.get_json_vars()
        self.assertEqual(json["PKG3_VERSION"]["expanded"], "foo_123")
        self.assertEqual(json["PKG3_DL_VERSION_FINAL"]["expanded"], "foo/123")
        self.assertEqual(json["HOST_PKG3_VERSION"]["expanded"], "bar_456")
        self.assertEqual(json["HOST_PKG3_DL_VERSION_FINAL"]["expanded"], "bar/456")

    def test_pkg4(self):
        json = self.get_json_vars()
        self.assertEqual(json["PKG4_VERSION"]["expanded"], "123")
        self.assertEqual(json["PKG4_DL_VERSION_FINAL"]["expanded"], "baz-123")
        self.assertEqual(json["HOST_PKG4_VERSION"]["expanded"], "123")
        self.assertEqual(json["HOST_PKG4_DL_VERSION_FINAL"]["expanded"], "baz-123")
