Return-Path: <linux-spi+bounces-8233-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF114AC0A11
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 12:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31048A2106F
	for <lists+linux-spi@lfdr.de>; Thu, 22 May 2025 10:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A087266562;
	Thu, 22 May 2025 10:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b7qlbFlu"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3029C33DB;
	Thu, 22 May 2025 10:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747910857; cv=none; b=dcekPoY9ygbUBOqRqPbqn9GHAXy6LCcjYanYTMEBGLR9m3GYDx5gmwcivdmrwzVaEP2UROI+Asq9N16mwJ5IyEuKD0Fjrb4baN+DlIjGAeh19HXCVyiCRZEgbzYa9DmD3glVbPTtGau4POVXZjg0W8zM7SgXjyXntqFoJBWLVSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747910857; c=relaxed/simple;
	bh=2XCxImrdcg6+7NaD9mTOQb0dWzeNFJsZamV2rMfEfH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mgVi+lYapFKGBzrbSn1bUS6ULcu2Ug17I/smKupvRSJqdALbwjGvHJW3n/YfTamxiZZ6oP/vlTg6mV952CpM9p5089kzQ0X5AeDvtZeJIgqcclAJ+niD0QWduesWcjkTjG4UaP5PnMls47CAB/wWpKBmTofq1YEGd0lyrTa2ICU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b7qlbFlu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00466C4CEE4;
	Thu, 22 May 2025 10:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747910856;
	bh=2XCxImrdcg6+7NaD9mTOQb0dWzeNFJsZamV2rMfEfH8=;
	h=From:To:Cc:Subject:Date:From;
	b=b7qlbFluo7o8UZK0fdtddsXzci8pF3lv/8mFRuADe31Uc/mvwBjDOP5ssc4vrjG5h
	 4iqCODHgrCy/Szpa9V3Nqak9uGA7TO1Vr6wlkByXMEbnmh6vizyKalIQh3U2Z+1rhj
	 QP3Y9t8LeKF9qMRVsFbrcWEozYzInSQbDka9VEoM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-spi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] spi: use container_of_cont() for to_spi_device()
Date: Thu, 22 May 2025 12:47:31 +0200
Message-ID: <2025052230-fidgeting-stooge-66f5@gregkh>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 34
X-Developer-Signature: v=1; a=openpgp-sha256; l=1509; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=2XCxImrdcg6+7NaD9mTOQb0dWzeNFJsZamV2rMfEfH8=; b=owGbwMvMwCRo6H6F97bub03G02pJDBn6DIeYsuovdd7n1/kudmL+Ac25DzhnSc7+cWLJoxccb tl51n7GHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCR+tkMC9rkt9alnhNmd13d kvXDK2nyoitVpQwLNtkpFBS/4Jrxpa/vsJXD4V2MKufNAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Some places in the spi core pass in a const pointer to a device and the
default container_of() casts that away, which is not a good idea.
Preserve the proper const attribute by using container_of_const() for
to_spi_device() instead, which is what it was designed for.

Note, this removes the NULL check for a device pointer in the call, but
no one was ever checking for that return value, and a device pointer
should never be NULL overall anyway, so this should be a safe change.

Cc: Mark Brown <broonie@kernel.org>
Fixes: d69d80484598 ("driver core: have match() callback in struct bus_type take a const *")
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/spi/spi.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 0ba5e49bace4..6e64f0193777 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -249,10 +249,7 @@ struct spi_device {
 static_assert((SPI_MODE_KERNEL_MASK & SPI_MODE_USER_MASK) == 0,
 	      "SPI_MODE_USER_MASK & SPI_MODE_KERNEL_MASK must not overlap");
 
-static inline struct spi_device *to_spi_device(const struct device *dev)
-{
-	return dev ? container_of(dev, struct spi_device, dev) : NULL;
-}
+#define to_spi_device(__dev)	container_of_const(__dev, struct spi_device, dev)
 
 /* Most drivers won't need to care about device refcounting */
 static inline struct spi_device *spi_dev_get(struct spi_device *spi)
-- 
2.49.0


