Return-Path: <linux-spi+bounces-6325-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7519A0A590
	for <lists+linux-spi@lfdr.de>; Sat, 11 Jan 2025 20:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01471885DD0
	for <lists+linux-spi@lfdr.de>; Sat, 11 Jan 2025 19:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86071B4147;
	Sat, 11 Jan 2025 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="deuvm6q9"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B50322083;
	Sat, 11 Jan 2025 19:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736622541; cv=none; b=Hpitqo7hbr9LbA4QGWBNJLSuKJZa6yLrvwHaN6tysuLFlLkHaFJx4se/Y9Yegv03RCDhMo1uPh1HxKXwbwQDV5P4OTye/JjBGEmImaqchQ9ZauLlPi/uHW9hF0CoSRwD7SA/wPOmUa5qbs4SRQGyWPU82XaWAluJZBE65JTAi6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736622541; c=relaxed/simple;
	bh=WwYW42JvpW0nfeStKB+/FvmdEPZw4aogO0d6MLliTLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ocKH8SON3wmWWHKUYlO3mwKg4MMDQoyVmcJzXFCML65cfMMcKzOGGTskePrQG2SJ7Wikf9h+5nW5Z/i06THtlq0zzfHGnWt8AdewzponEawjZKnRCnAcpa7sEQ3lRNiFH+FRg1bVB6RQL30DmnRQVF+z4vKVqWBZuVHkfV1cCho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=deuvm6q9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B505EC4CED2;
	Sat, 11 Jan 2025 19:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736622541;
	bh=WwYW42JvpW0nfeStKB+/FvmdEPZw4aogO0d6MLliTLw=;
	h=From:Date:Subject:To:Cc:From;
	b=deuvm6q91DkUntjgvy5pexbYEWzZGD3mddRs9+nvLNNDVuDtpOhQXwgMxUzJgkT7C
	 UMOI5UhnXXP5Ls7f5YvfYuACBxvulQKueKCATIYNi/HlcXFy/ZEvGzYixsqENYARAp
	 KqJMutSrFU+M06yS7xz4cfJms4E+xPy2918/wAeNWNlwiK5AOX7i9V58Z7++jDKM/o
	 kmMYLC2f6WXoNMCU5WaeOI4/Vb4LlUPDCBLsNCb0P1s88q6Bipvsu/n6g5ESN0ys2a
	 OBUeqGCQaPW8UV99L8DvEIv5NREUBbV5L7BOQmK0HFu0LgrgWlqVFP9fg/vvWBk6Wy
	 firOeeAZphltg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Sat, 11 Jan 2025 12:08:38 -0700
Subject: [PATCH] spi: amd: Fix -Wuninitialized in amd_spi_exec_mem_op()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250111-spi-amd-fix-uninitialized-ret-v1-1-c66ab9f6a23d@kernel.org>
X-B4-Tracking: v=1; b=H4sIALXBgmcC/x3MQQrDIBBG4auEWWcgarNorxKyMDo2P7RGNAmlw
 btXuvzg8S4qkiGFHt1FWU4UbLFB9R251canMHwz6UGPg1KKSwLbt+eADx8RETvsC1/xnGXnxS1
 OizE23G/UHilLC///aa71B+j+BSdvAAAA
X-Change-ID: 20250111-spi-amd-fix-uninitialized-ret-bcbc2e33af94
To: Raju Rangoju <Raju.Rangoju@amd.com>, Mark Brown <broonie@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: linux-spi@vger.kernel.org, llvm@lists.linux.dev, 
 patches@lists.linux.dev, kernel test robot <lkp@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1941; i=nathan@kernel.org;
 h=from:subject:message-id; bh=WwYW42JvpW0nfeStKB+/FvmdEPZw4aogO0d6MLliTLw=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOlNB09XL3kSZXDtpLGrUOji24ut2LimBP9UjFe/Nn/fO
 b/bKcX1HaUsDGJcDLJiiizVj1WPGxrOOct449QkmDmsTCBDGLg4BWAinRKMDF+1Padc+/zv4qRX
 bnOPcu4JzvFZZLL9/pvSP16L+VK0rqxhZFiwM9b62j2uHZq8e5fq54lP92g/vtXxyzHx7UWT4gx
 4/bkB
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit e6204f39fe3a ("spi: amd: Drop redundant check"), clang warns (or
errors with CONFIG_WERROR=y):

  drivers/spi/spi-amd.c:695:9: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
    695 |         return ret;
        |                ^~~
  drivers/spi/spi-amd.c:673:9: note: initialize the variable 'ret' to silence this warning
    673 |         int ret;
        |                ^
        |                 = 0
  1 error generated.

ret is no longer set on anything other than the default switch path.
Replace ret with a direct return of 0 at the end of the function and
-EOPNOTSUPP in the default case to resolve the warning.

Fixes: e6204f39fe3a ("spi: amd: Drop redundant check")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501112315.ugYQ7Ce7-lkp@intel.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/spi/spi-amd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index fbe795bbcf507abcbbd973b226b5db0de1584898..c85997478b81903c97636d271baf7d378914c50a 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -670,7 +670,6 @@ static int amd_spi_exec_mem_op(struct spi_mem *mem,
 			       const struct spi_mem_op *op)
 {
 	struct amd_spi *amd_spi;
-	int ret;
 
 	amd_spi = spi_controller_get_devdata(mem->spi->controller);
 
@@ -689,10 +688,10 @@ static int amd_spi_exec_mem_op(struct spi_mem *mem,
 		amd_spi_mem_data_out(amd_spi, op);
 		break;
 	default:
-		ret = -EOPNOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
-	return ret;
+	return 0;
 }
 
 static const struct spi_controller_mem_ops amd_spi_mem_ops = {

---
base-commit: 226d6cb3cb799aae46d0dd19a521133997d9db11
change-id: 20250111-spi-amd-fix-uninitialized-ret-bcbc2e33af94

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


