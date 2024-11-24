Return-Path: <linux-spi+bounces-5807-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9E19D6F79
	for <lists+linux-spi@lfdr.de>; Sun, 24 Nov 2024 14:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BAF2160F05
	for <lists+linux-spi@lfdr.de>; Sun, 24 Nov 2024 13:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660561AAE02;
	Sun, 24 Nov 2024 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dk/rQ0oe"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E501AA78B;
	Sun, 24 Nov 2024 12:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452688; cv=none; b=a/b24xXzS7tsVx4ttCZqte7wmnfncjV9rdZLaqxmqZVQhq/CHKS3QPeQnkNfJ6X99D7kJA23qLDnqilf0LL4/vUgRbymmbDrLBj177ed0wv03W1sbFMvK45aWZDtZmSIDantAqiEcV+XSp5jGeQw0+tFx75z1i6o9C2ePdhgfZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452688; c=relaxed/simple;
	bh=r9UHBgJlSBenZzEj8ZbrIVDOfkVGTV/88zxZVPmAKaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=As4qVsRnjQHbs+ecDh+3UkZA0G3gdJ26nnainSupEb78sASYVbvuvrnDROoBxO0ghGViIK/DDyAz7HeLqGzDMhb1BOy9TdNGWG2flZfFPf2r5/srZDubH4G4pzprkL2zng+NW7SQKxNoLwmCUJyCWQGiNCUeAiRav4n3/RdxacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dk/rQ0oe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3017DC4CED1;
	Sun, 24 Nov 2024 12:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452688;
	bh=r9UHBgJlSBenZzEj8ZbrIVDOfkVGTV/88zxZVPmAKaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dk/rQ0oeFXe6brT2jZgDSWp4x8OyNe25uU/cBOxfUnyl+14VUYymcT4WwyiwGuL5/
	 kcNcMoKKo6upIA0+XL8Og5gOSPwwDaAHbjcDl78ZLtbLWrBwwV5aD6yMHxDHmX4ZPE
	 1aeAF15/L8ACqG6o06VNXyE9iTzNrMbi7WhvoDiYgHtgBJhqyWw9mvfHLnv+25Xw19
	 sc36iVEnT/by/NNg/fkVxkQIl+KogQEFdBAQlQmYjiZKlywzIr7L0LMa1MvoMKjdSE
	 l7QmduCybZSP9Xe8EuffOawClWhZrfqHbV24HMtUAvN9u0JCZj3mh70Z/Y+54JNlb0
	 gKflQRvq+EWeg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Wahren <wahrenst@gmx.net>,
	Frank Li <Frank.Li@nxp.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH AUTOSEL 6.11 02/20] spi: spi-fsl-lpspi: Adjust type of scldiv
Date: Sun, 24 Nov 2024 07:50:32 -0500
Message-ID: <20241124125124.3339648-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124125124.3339648-1-sashal@kernel.org>
References: <20241124125124.3339648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Stefan Wahren <wahrenst@gmx.net>

[ Upstream commit fa8ecda9876ac1e7b29257aa82af1fd0695496e2 ]

The target value of scldiv is just a byte, but its calculation in
fsl_lpspi_set_bitrate could be negative. So use an adequate type to store
the result and avoid overflows. After that this needs range check
adjustments, but this should make the code less opaque.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20240930093056.93418-2-wahrenst@gmx.net
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-fsl-lpspi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 977e8b55c82b7..196cc68f2057b 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -315,9 +315,10 @@ static void fsl_lpspi_set_watermark(struct fsl_lpspi_data *fsl_lpspi)
 static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 {
 	struct lpspi_config config = fsl_lpspi->config;
-	unsigned int perclk_rate, scldiv, div;
+	unsigned int perclk_rate, div;
 	u8 prescale_max;
 	u8 prescale;
+	int scldiv;
 
 	perclk_rate = clk_get_rate(fsl_lpspi->clk_per);
 	prescale_max = fsl_lpspi->devtype_data->prescale_max;
@@ -338,13 +339,13 @@ static int fsl_lpspi_set_bitrate(struct fsl_lpspi_data *fsl_lpspi)
 
 	for (prescale = 0; prescale <= prescale_max; prescale++) {
 		scldiv = div / (1 << prescale) - 2;
-		if (scldiv < 256) {
+		if (scldiv >= 0 && scldiv < 256) {
 			fsl_lpspi->config.prescale = prescale;
 			break;
 		}
 	}
 
-	if (scldiv >= 256)
+	if (scldiv < 0 || scldiv >= 256)
 		return -EINVAL;
 
 	writel(scldiv | (scldiv << 8) | ((scldiv >> 1) << 16),
-- 
2.43.0


