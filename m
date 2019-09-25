Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AABABDC17
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2019 12:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389505AbfIYKWy (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Sep 2019 06:22:54 -0400
Received: from mxc1.seznam.cz ([77.75.79.23]:49409 "EHLO mxc1.seznam.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727698AbfIYKWy (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Wed, 25 Sep 2019 06:22:54 -0400
X-Greylist: delayed 842 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Sep 2019 06:22:53 EDT
Received: from email.seznam.cz
        by email-smtpc6b.ko.seznam.cz (email-smtpc6b.ko.seznam.cz [10.53.13.165])
        id 539932f0ad6d805a5317bce8;
        Wed, 25 Sep 2019 12:22:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=email.cz; s=beta;
        t=1569406971; bh=oQiwXLYi8hMSZoe4wRWBNTUoQhrxRuLtlRt5MXlWS/A=;
        h=Received:From:To:Subject:Date:Message-Id:Mime-Version:X-Mailer:
         Content-Type:Content-Transfer-Encoding;
        b=HQxww2wArMllzZo8vFWYMfG0RNf+gtYE6/eIua7m04+/AasVWLu/wVzut/8BltHE+
         28+y4LwoBU31J6FNOqiEaWNoeqZaPoC5bK8OxVDEE/Fq6zpxt+gDYlxBezeVqE+qcZ
         HWGGfgiO3ZPc+CgZqklFo6VrMfOM/8fvL565jmAI=
Received: from unknown ([::ffff:85.207.4.114])
        by email.seznam.cz (szn-ebox-4.5.362) with HTTP;
        Wed, 25 Sep 2019 12:08:44 +0200 (CEST)
From:   <tomaspaukrt@email.cz>
To:     <broonie@kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH] spi: orion: fix runtime PM initialization
Date:   Wed, 25 Sep 2019 12:08:44 +0200 (CEST)
Message-Id: <E2A.ZWgn.6sH16TohXKE.1TYpoi@seznam.cz>
Mime-Version: 1.0 (szn-mime-2.0.45)
X-Mailer: szn-ebox-4.5.362
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

The current initialisation of runtime PM in the orion-spi.c driver is
incorrect, because calling pm_runtime_put_autosuspend before calling
pm_runtime_get leads to a negative value of the reference count and
therefore it sometimes causes suspend during a transmission.

Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>
---
 drivers/spi/spi-orion.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 6643ccdc2508..81c991c4ddbf 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -772,9 +772,6 @@ static int orion_spi_probe(struct platform_device *pde=
v)
 	if (status < 0)
 		goto out_rel_pm;
 
-	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
-
 	master->dev.of_node =3D pdev->dev.of_node;
 	status =3D spi_register_master(master);
 	if (status < 0)
-- 
2.17.1

