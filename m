Return-Path: <linux-spi+bounces-7844-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3A7AA6F1F
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 12:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 648197B5EE4
	for <lists+linux-spi@lfdr.de>; Fri,  2 May 2025 10:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEFC23C4EF;
	Fri,  2 May 2025 10:14:17 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A966F23C4F7
	for <linux-spi@vger.kernel.org>; Fri,  2 May 2025 10:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746180857; cv=none; b=LY1YIzpyCTZKSmPx5TRGtXHM8jpr/RL48fQhaiREUYjienMEiVCQXAzdoZNh21r+9QtP1qIk+5iXZg3X5ilV6kzmTf4tC4neW+F+OnEKyK4m6keLibG5ejtfw8DnXTUWAXngfNYDnN7e/c1GKLSf7c6KDCRh8zk60kM66iARyaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746180857; c=relaxed/simple;
	bh=2eqVnUZBwrfjmIS21M7Y79WYMnohfN8iZlDyk5bQvX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XZP+a6vZSjx1I1RIlRGMlVoNtj5FDtCC4BVj5y7lsd31uCqh4avGCtb59VTV9TlocDvwctnFyzOfnCi1XlhZI8YJE7gKNhlupWhyeRjl38QLd/g4wUfkuLm5npsT5Jmb/hGPoNeaFHrZq78ijyXQbFo568zUQXcLfHO4W9oqCfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:df64:35e8:502:4ac0])
	by michel.telenet-ops.be with cmsmtp
	id kAE02E0104sst1106AE0oh; Fri, 02 May 2025 12:14:01 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP2-00000000WAX-19a4;
	Fri, 02 May 2025 12:14:00 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uAnP6-00000008oXi-2yfq;
	Fri, 02 May 2025 12:14:00 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Koji Matsuoka <koji.matsuoka.xm@renesas.com>
Cc: linux-spi@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 20/22] spi: sh-msiof: Document frame start sync pulse mode
Date: Fri,  2 May 2025 12:13:52 +0200
Message-ID: <e50f4dd4fdc23c1e3f2abece458fe178b76ada1f.1746180072.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1746180072.git.geert+renesas@glider.be>
References: <cover.1746180072.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unused, but nice to have it documented.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 4d9a44118e1c9d6c..5d9d551dbd220389 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -86,6 +86,7 @@ struct sh_msiof_spi_priv {
 /* SITMDR1 and SIRMDR1 */
 #define SIMDR1_TRMD		BIT(31)		/* Transfer Mode (1 = Master mode) */
 #define SIMDR1_SYNCMD		GENMASK(29, 28)	/* SYNC Mode */
+#define SIMDR1_SYNCMD_PULSE	0U		/*   Frame start sync pulse */
 #define SIMDR1_SYNCMD_SPI	2U		/*   Level mode/SPI */
 #define SIMDR1_SYNCMD_LR	3U		/*   L/R mode */
 #define SIMDR1_SYNCAC		BIT(25)		/* Sync Polarity (1 = Active-low) */
-- 
2.43.0


