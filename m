Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78027146043
	for <lists+linux-spi@lfdr.de>; Thu, 23 Jan 2020 02:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbgAWBYG (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jan 2020 20:24:06 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:36140 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAWBYG (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jan 2020 20:24:06 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 56BF083640;
        Thu, 23 Jan 2020 14:24:03 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1579742643;
        bh=EQZqOLnUuKakn1KmMPjNCgsEbo3zAAhg/fJw/2TVSeo=;
        h=From:To:Cc:Subject:Date;
        b=rZi5EOPrmaNR52Z9ZM1ZiubQGFlryAtcQGa0A5hkTMfBMgxAmVWCQWU/qHobbeaCF
         67A7tHq3OtO6izuGOm+t9UcBsWOJneYpMQE7wyyqDer2tAXqO6eOLsNKH1Z0RVmtYF
         5zKofospWdfZznOc1qqKhKUvcdghZvYSxRMA8E3ZBCM4c3t+I3+Vc3xHWSvmbycPYo
         d3h96NtBTWYO4e9uiUL5eKo3o8FlOPrDWxAMVeCGm4C5PSABPLMmz7sE1Zph+Me14a
         Mx+AsUnZP+2i9s+HO9y+YOsUQs60jVbIR91daUF0anBjhAWzjpPL2eJlI/JsXh0idw
         jm26O1VwmtOtg==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5e28f58c0000>; Thu, 23 Jan 2020 14:23:28 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 1BA4813EEB9;
        Thu, 23 Jan 2020 14:23:23 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id 78F16280071; Thu, 23 Jan 2020 14:23:24 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v2 0/2] SPI bus multiplexing
Date:   Thu, 23 Jan 2020 14:23:15 +1300
Message-Id: <20200123012317.14808-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This is a revisit of two earlier efforts to add more complex mutliplexing=
 to
SPI busses.

https://patchwork.kernel.org/patch/2706151/
https://patchwork.kernel.org/patch/10897255/

This version makes use of the general purpose mux controller which simpli=
fies
things greatly.

One outstanding problem is the need for the spi-max-frequency on the mux
device. This is not used for anything and is just needed to satisfy the s=
pi
driver infrastructure which expects all spi devices to have this property=
.

Chris Packham (2):
  dt-bindings: spi: Document binding for generic SPI multiplexer
  spi: Add generic SPI multiplexer

 .../devicetree/bindings/spi/spi-mux.yaml      |  84 ++++++++
 drivers/spi/Kconfig                           |  12 ++
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-mux.c                         | 189 ++++++++++++++++++
 4 files changed, 286 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-mux.yaml
 create mode 100644 drivers/spi/spi-mux.c

--=20
2.25.0

