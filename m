Return-Path: <linux-spi+bounces-8173-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 263D1AB9D85
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 15:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 030B87B5189
	for <lists+linux-spi@lfdr.de>; Fri, 16 May 2025 13:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA35158DA3;
	Fri, 16 May 2025 13:32:48 +0000 (UTC)
X-Original-To: linux-spi@vger.kernel.org
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4F113A258
	for <linux-spi@vger.kernel.org>; Fri, 16 May 2025 13:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747402368; cv=none; b=I4Okcu2GPFbCFICkV5lc74xG0I/7CmEmcbjLIA+FW9ETtKoxVk6lm2EI/KkrzER6hrs5V39CeacO/pWP69kDo6iTMybhbeTuhvulAzrXkhdFF2A1rC/glo6fXwBkkwXfPFi2rc0DMlKQnVtYLgrGQk6i9ozjcbwbEYC7b99HXoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747402368; c=relaxed/simple;
	bh=ZBOsQkCpQk4NFJntcIIfakChp5hPIRtn0jQyyUZmxqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ddM3WmvylwaF9GCxSSwE054wYez0qrwt0MW8TEqTD7BCZZu7YFL5G4XnRr9g+IMXvs4cJYMrgqF0ZWlB/Kk/iFEfKUQZ6X9GhTF4odswD4I5LtyQcjvfTxeugWSBpvZiLcfsNM7kB5lxN847AtY/HDncActuckQyaICosp0MLmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:b0d6:ccd4:58dc:70fd])
	by laurent.telenet-ops.be with cmsmtp
	id ppYX2E0083S8nz401pYX64; Fri, 16 May 2025 15:32:33 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAi-000000020iT-0ulD;
	Fri, 16 May 2025 15:32:31 +0200
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1uFvAt-0000000152H-2YGG;
	Fri, 16 May 2025 15:32:31 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Koji Matsuoka <koji.matsuoka.xm@renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-spi@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 04/22] spi: sh-msiof: Complete using dev in sh_msiof_spi_probe()
Date: Fri, 16 May 2025 15:32:07 +0200
Message-ID: <88d271b2d16c6ad7f174858894573f91cec1bc90.1747401908.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747401908.git.geert+renesas@glider.be>
References: <cover.1747401908.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit c4887bd4b35b225f ("spi: sh-msiof: use dev in
sh_msiof_spi_probe()") forgot to convert one instance.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - No changes.
---
 drivers/spi/spi-sh-msiof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index cf93c2ca821f84fa..367622985fea2a04 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1332,7 +1332,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 		goto err1;
 	}
 
-	ret = devm_request_irq(dev, i, sh_msiof_spi_irq, 0, dev_name(&pdev->dev), p);
+	ret = devm_request_irq(dev, i, sh_msiof_spi_irq, 0, dev_name(dev), p);
 	if (ret) {
 		dev_err(dev, "unable to request irq\n");
 		goto err1;
-- 
2.43.0


