Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5ABBB4A16
	for <lists+linux-spi@lfdr.de>; Tue, 17 Sep 2019 11:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbfIQJMY (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 17 Sep 2019 05:12:24 -0400
Received: from mail-40132.protonmail.ch ([185.70.40.132]:48377 "EHLO
        mail-40132.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbfIQJMX (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 17 Sep 2019 05:12:23 -0400
Date:   Tue, 17 Sep 2019 09:12:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aurabindo.in;
        s=protonmail; t=1568711541;
        bh=ZKYIzKdgRRtrB7OyOmWDzTMGg6uay9ipjlu1WQonyTU=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=eQjSy21KM5OSXxxHfL1Q0qHO98l3ynqXu8fnUA4rHJu0AHrC6MQbLJr3PyVby+VLd
         HftIbwWlow6/FRq+UwbpO4l5ArWqYTCd+B5WEmp/Ozjw7Y/szu+/yOmVBRq/qx4u4A
         NkAgdHx082bP+SO2K8f2zMj/58ejxv+TrWH7LCa4=
To:     broonie@kernel.org, palmer@sifive.com, paul.walmsley@sifive.com
From:   Aurabindo Jayamohanan <mail@aurabindo.in>
Cc:     linux-spi@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Reply-To: Aurabindo Jayamohanan <mail@aurabindo.in>
Subject: [PATCH] spi: sifive: check return value for platform_get_resource()
Message-ID: <20190917091207.4925-1-mail@aurabindo.in>
Feedback-ID: D1Wwva8zb0UdpJtanaReRLGO3iCsewpGmDn8ZDKmpao-Gnxd2qXPmwwrSQ99r5Q15lmK-D8x6vKzqhUKCgzweA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

platform_get_resource() may return NULL. If it is so, return -ENXIO

Signed-off-by: Aurabindo Jayamohanan <mail@aurabindo.in>
---
 drivers/spi/spi-sifive.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 93ec2c6cdbfd..67485067a694 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -308,6 +308,12 @@ static int sifive_spi_probe(struct platform_device *pd=
ev)
 =09platform_set_drvdata(pdev, master);
=20
 =09res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
+=09if (!res) {
+=09=09dev_err(&pdev->dev, "no IOMEM resource found\n");
+=09=09ret =3D -ENXIO;
+=09=09goto put_master;
+=09}
+
 =09spi->regs =3D devm_ioremap_resource(&pdev->dev, res);
 =09if (IS_ERR(spi->regs)) {
 =09=09ret =3D PTR_ERR(spi->regs);
--=20
2.23.0


