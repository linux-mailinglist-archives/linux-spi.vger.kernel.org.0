Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88B1720548
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2019 13:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfEPLmK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 May 2019 07:42:10 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:54244 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728490AbfEPLmK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 May 2019 07:42:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Y0oYUmc+BE/gKaq1jzd+TH8E5vrmF/vem/gskRDoX8E=; b=PYSxkMeOVTuf
        LpZbgSTItQ4ejHf+AW/mh+Whtn6cSUAMKvxbIq2wT6/W4nkXDZBYV+Jh53ymR3hU+egYZK9EYZHPU
        +92MZ7U7xqh7RHrjRAVpuuztvzz8NcVt7+EUJXqt5N3VzyTSSrS1Z9rpsJgRgny/UtZROVP9WsaP5
        9cXuw=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1hREm0-0006A4-7x; Thu, 16 May 2019 11:42:08 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 714FD1126D45; Thu, 16 May 2019 12:42:07 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic3x: Add support for high power analog output" to the spi tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190516114207.714FD1126D45@debutante.sirena.org.uk>
Date:   Thu, 16 May 2019 12:42:07 +0100 (BST)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The patch

   ASoC: tlv320aic3x: Add support for high power analog output

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 212bf7a60bd29ff4378c8d355526bf317dc8432c Mon Sep 17 00:00:00 2001
From: Saravanan Sekar <sravanhome@gmail.com>
Date: Sat, 11 May 2019 17:11:49 +0200
Subject: [PATCH] ASoC: tlv320aic3x: Add support for high power analog output

Add support to output level control for the analog high power output
drivers HPOUT and HPCOM.

Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic3x.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic3x.c
index 516d17cb2182..599e4ed3850b 100644
--- a/sound/soc/codecs/tlv320aic3x.c
+++ b/sound/soc/codecs/tlv320aic3x.c
@@ -324,6 +324,9 @@ static DECLARE_TLV_DB_SCALE(adc_tlv, 0, 50, 0);
  */
 static DECLARE_TLV_DB_SCALE(output_stage_tlv, -5900, 50, 1);
 
+/* Output volumes. From 0 to 9 dB in 1 dB steps */
+static const DECLARE_TLV_DB_SCALE(out_tlv, 0, 100, 0);
+
 static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 	/* Output */
 	SOC_DOUBLE_R_TLV("PCM Playback Volume",
@@ -386,11 +389,17 @@ static const struct snd_kcontrol_new aic3x_snd_controls[] = {
 			 DACL1_2_HPLCOM_VOL, DACR1_2_HPRCOM_VOL,
 			 0, 118, 1, output_stage_tlv),
 
-	/* Output pin mute controls */
+	/* Output pin controls */
+	SOC_DOUBLE_R_TLV("Line Playback Volume", LLOPM_CTRL, RLOPM_CTRL, 4,
+			 9, 0, out_tlv),
 	SOC_DOUBLE_R("Line Playback Switch", LLOPM_CTRL, RLOPM_CTRL, 3,
 		     0x01, 0),
+	SOC_DOUBLE_R_TLV("HP Playback Volume", HPLOUT_CTRL, HPROUT_CTRL, 4,
+			 9, 0, out_tlv),
 	SOC_DOUBLE_R("HP Playback Switch", HPLOUT_CTRL, HPROUT_CTRL, 3,
 		     0x01, 0),
+	SOC_DOUBLE_R_TLV("HPCOM Playback Volume", HPLCOM_CTRL, HPRCOM_CTRL,
+			 4, 9, 0, out_tlv),
 	SOC_DOUBLE_R("HPCOM Playback Switch", HPLCOM_CTRL, HPRCOM_CTRL, 3,
 		     0x01, 0),
 
@@ -472,6 +481,9 @@ static const struct snd_kcontrol_new aic3x_mono_controls[] = {
 			 0, 118, 1, output_stage_tlv),
 
 	SOC_SINGLE("Mono Playback Switch", MONOLOPM_CTRL, 3, 0x01, 0),
+	SOC_SINGLE_TLV("Mono Playback Volume", MONOLOPM_CTRL, 4, 9, 0,
+			out_tlv),
+
 };
 
 /*
-- 
2.20.1

