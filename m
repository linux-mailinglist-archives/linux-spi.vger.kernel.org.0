Return-Path: <linux-spi+bounces-3738-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B117A9275B2
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 14:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D5C4B21300
	for <lists+linux-spi@lfdr.de>; Thu,  4 Jul 2024 12:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987031AD9D8;
	Thu,  4 Jul 2024 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrsWYMDc"
X-Original-To: linux-spi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700EC1ACE7E;
	Thu,  4 Jul 2024 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720094756; cv=none; b=jicbnwclPjec1y4nBZbEVLXug04lnwM8592e8+rkP/KVghwVGfdw5qarWRHBdBjmxvEQIOhLber6/yeHvW+ZJ4EXY+O5upkKhR3sESTkf7sMpS7o9Lme3/OY/qs1ncenToPvffBL5cQOFIlC/6Txny4USce3HBrJydWxDbLUe48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720094756; c=relaxed/simple;
	bh=tgabevy+QP/BxviO8/iWVUYEucraiguvzRh3eXny1PA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WrFLYboZ3vEYHM1Q6rfCGwMJl+pVTFQlBzLx2zizDgCZ8X2Gwc4aD7IHPPKC2UuG7tdjAXfAheTwMQXn3WFGVWGftGDIOqj686Yowant3bgectZlnZ7/rhLJwpKjOgNq38Aw4KLes8e0JHug/TDPi7p0iuruKca6R+Xdym0/Rns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrsWYMDc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9A8C3277B;
	Thu,  4 Jul 2024 12:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720094756;
	bh=tgabevy+QP/BxviO8/iWVUYEucraiguvzRh3eXny1PA=;
	h=From:Date:Subject:To:Cc:From;
	b=WrsWYMDc/BdKLy+XmcQf0ZQnz2QSh/UCm3KXhbthTeh/lyKk8OGjbRpKLv5XPOBvK
	 fjGyVX3PVqVWhuCroFVaDXwP6BT/OqZm7kejJzWPnI8wQ79tLRnWGRzd0qhVTLEWB7
	 01CDUC7m3Die9hdh46AMDJLbBu9ypC8f5w2Jqtjs3+YSd49n1EAVDIkyFPG9w3+Cm7
	 iv2JlH9gD4gnY4BHQtqr+PK2Jc9us/kY2F4LohwwgUVzJz5iN0cOGPVGeirVW6u1bE
	 q8HVERoYZZLG2ze2tPXaU1Eui2SiVIrFGphu0eRki+53gjPztMyV4pwPc252jIWQ7Z
	 W0HXYLlOZNv6w==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 04 Jul 2024 13:05:48 +0100
Subject: [PATCH] spi: omap2-mcspi: Revert multi mode support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240704-spi-revert-omap2-multi-v1-1-69357ef13fdc@kernel.org>
X-B4-Tracking: v=1; b=H4sIABuQhmYC/x2MSQqAMAwAvyI5G4i1LvgV8SAaNeBS2ipC6d8tH
 gdmJoBjK+ygywJYfsTJdSYo8gymbTxXRpkTgyKlqaESnRFMIluP1zEahce9e0Ei1eqWuK4mDSk
 2lhd5/3E/xPgBZM9Gj2gAAAA=
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Colin Foster <colin.foster@in-advantage.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>, 
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=2590; i=broonie@kernel.org;
 h=from:subject:message-id; bh=tgabevy+QP/BxviO8/iWVUYEucraiguvzRh3eXny1PA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmhpAhKeMAIs0yia3pRJRyhC9V4ldg1ZaZrwpOh2GO
 0VNxlgSJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZoaQIQAKCRAk1otyXVSH0H+mB/
 4j9uBvFrWjX3vmvuoAdjJ1ornsYlNKtIXy7XnEnnlNRETF6QJKsurpL4k78WR6ot4xHJ7P3y+BbyJp
 5iIuhOotbDilmx9f3SPEDio+63rwyFCyxsWftG+wQh97G3ivk6NKyxSFbAemary7KJ66LtDYxUNzjH
 qCpBkl7BWe8J0WWQphnA1agE7RL4ijsZJwfby+mL4KyyR9PGzn1R3hO9hRDXKXli+r7I1cO9zVDFUk
 cddOTCjdZaW4LjRFJx2ipexe30sWpunzelIeiHSGQE5lSoYOKGQO4JxeZX1IDgP7B601K6EJwY2OqN
 atM/Uqpb+TeXrFnkJr8s55U6dDtfKZ
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There have been multiple reports that the multi-mode support in the
OMAP2 McSPI driver has caused regressions on existing systems.  There's
been some discussion and some proposed changes but nothing that's been
tested by all the reporters.  Drop the patch for v6.10, hopefully we can
get to the bottom of the issue and reenable the feature for v6.11.

Reported-by: Colin Foster <colin.foster@in-advantage.com>
Reported-by: João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
Fixes: e64d3b6fc9a3 ("spi: omap2-mcpsi: Enable MULTI-mode in more situations")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-omap2-mcspi.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 7e3083b83534..002f29dbcea6 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1277,24 +1277,11 @@ static int omap2_mcspi_prepare_message(struct spi_controller *ctlr,
 
 		/*
 		 * Check if this transfer contains only one word;
-		 * OR contains 1 to 4 words, with bits_per_word == 8 and no delay between each word
-		 * OR contains 1 to 2 words, with bits_per_word == 16 and no delay between each word
-		 *
-		 * If one of the two last case is true, this also change the bits_per_word of this
-		 * transfer to make it a bit faster.
-		 * It's not an issue to change the bits_per_word here even if the multi-mode is not
-		 * applicable for this message, the signal on the wire will be the same.
 		 */
 		if (bits_per_word < 8 && tr->len == 1) {
 			/* multi-mode is applicable, only one word (1..7 bits) */
-		} else if (tr->word_delay.value == 0 && bits_per_word == 8 && tr->len <= 4) {
-			/* multi-mode is applicable, only one "bigger" word (8,16,24,32 bits) */
-			tr->bits_per_word = tr->len * bits_per_word;
-		} else if (tr->word_delay.value == 0 && bits_per_word == 16 && tr->len <= 2) {
-			/* multi-mode is applicable, only one "bigger" word (16,32 bits) */
-			tr->bits_per_word = tr->len * bits_per_word / 2;
 		} else if (bits_per_word >= 8 && tr->len == bits_per_word / 8) {
-			/* multi-mode is applicable, only one word (9..15,17..32 bits) */
+			/* multi-mode is applicable, only one word (8..32 bits) */
 		} else {
 			/* multi-mode is not applicable: more than one word in the transfer */
 			mcspi->use_multi_mode = false;

---
base-commit: 1762dc01fc78ef5f19693e9317eae7491c6c7e1b
change-id: 20240703-spi-revert-omap2-multi-0028480e65c4

Best regards,
-- 
Mark Brown <broonie@kernel.org>


