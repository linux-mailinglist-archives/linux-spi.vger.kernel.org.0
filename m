Return-Path: <linux-spi+bounces-7528-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B62A845DB
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 16:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F811BA1159
	for <lists+linux-spi@lfdr.de>; Thu, 10 Apr 2025 14:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E07428A3FE;
	Thu, 10 Apr 2025 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghrmQREC"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54428285402;
	Thu, 10 Apr 2025 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294095; cv=none; b=cpJHLsmVuBFd7mOH/tQuGvd0VLGeru+BDG8wKvCRh9J/aEzAqBpyg8CFP72SvoepBDuo1UtCCadTZDAoTJuo0Fjj/GAVAFp0ndxR4KZbByHOPsPac3Q3qIDC2SZEYy9OSP6k1NyMA/13zQi5NfvX8C82k6PX6sMRuLpZxvl/Ac4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294095; c=relaxed/simple;
	bh=YiToJ8zRhpFzCd3F32alGJcpncYth2pup43Hko30jhI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bBjuuxOKrSGWVdoW4NY98N0m4+rV+3Xs911/IfB0fXSY+GE61a5pbasHsPoQGclDup4Pn0nCoxwhgHwkRTrwrkULVVXGrQxKfhrXSDYtHRvp7k5qzxPl2JhWSam/CyYCMuN9LsDnUdjwCJzvh32saR3GL07rB7Cp7dA8xSV3g9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghrmQREC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AA2C4CEDD;
	Thu, 10 Apr 2025 14:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744294094;
	bh=YiToJ8zRhpFzCd3F32alGJcpncYth2pup43Hko30jhI=;
	h=From:To:Cc:Subject:Date:From;
	b=ghrmQRECmGVdHis5g98vNkXuio+b9CyMDBLf+Uh0iYJTBtt5A05UWUsgduZh8jx4L
	 F9j98XPCKm1nXGiTUJmHeCiJTHLJLI4M530oC5PesKAzpblA3sBOC40U2TiqmkMH6o
	 vvMZrCMH4Nngjj5i9dEth6Hj+96PVLp5VHqVbdx10vSwZzk51JqMkAcGEpFJAzZ7WA
	 oY/bU+AulpSGlBx0KQWRoOGdycdf8Xs2AWcqvcX8IEsKAJ4U+gxa+8lN71/ceIJ9CY
	 JL5hxbc0y/i7Y/OHcocxerAfGvha3gO51H3h8ZxxrZp0pBVzuiJaVGcoxA3NF+1fBQ
	 S7FokBvVfEhbA==
From: Arnd Bergmann <arnd@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Raju Rangoju <Raju.Rangoju@amd.com>,
	Akshata MukundShetty <akshata.mukundshetty@amd.com>,
	Krishnamoorthi M <krishnamoorthi.m@amd.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: amd: add CONFIG_PCI dependency
Date: Thu, 10 Apr 2025 16:07:49 +0200
Message-Id: <20250410140809.812863-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Without CONFIG_PCI, the module_pci_driver() macro is not defined:

drivers/spi/spi-amd-pci.c:67:1: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
   67 | module_pci_driver(amd_spi_pci_driver);

Fixes: b644c2776652 ("spi: spi_amd: Add PCI-based driver for AMD HID2 SPI controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 52598f8e7848..b2f5b29980a2 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1266,6 +1266,7 @@ config SPI_ZYNQMP_GQSPI
 
 config SPI_AMD
 	tristate "AMD SPI controller"
+	depends on PCI
 	depends on SPI_MASTER || COMPILE_TEST
 	help
 	  Enables SPI controller driver for AMD SoC.
-- 
2.39.5


