Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D9CB4F26A6
	for <lists+linux-spi@lfdr.de>; Thu,  7 Nov 2019 05:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733212AbfKGEmk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 6 Nov 2019 23:42:40 -0500
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:49728 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733201AbfKGEmk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 6 Nov 2019 23:42:40 -0500
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 0410D886BF;
        Thu,  7 Nov 2019 17:42:38 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1573101758;
        bh=StLCXVge82VbJcyGSyaE6MC1vdSTbQKfxMGAum6myqU=;
        h=From:To:Cc:Subject:Date;
        b=gg136++WSYzW3ddjXJvecj4jSi0Cc326NAvyMSn6Y4vxV6UYnDhrC6IUokAzmnTIo
         ovfrqcXctmnfZbXbXf6/84yvDadOOt24g7VNxznhRcK6xionwdVKWgXe0MX/B84cRX
         7ZW2C+7R64StrFWxzrpHHcscwZ4d6pmlts82OXMrRZAjL4s20ABokXUB873Z7XTqd1
         t5SPB/+V6Dn81XsLfz/961ci1Tc3AtDmafd0RZN5fZg4jO1MOtbZ7SGIJvC8PkiO8n
         SZnDmSE65I+3TIgDX5hUNlYAwStfEIE+mzwZKs0WxEMHyvWtoZvNRWujCSKjjhYGVb
         7IbOMvJtwhcsA==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5dc3a0be0000>; Thu, 07 Nov 2019 17:42:38 +1300
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id 2D9CB13EEEB;
        Thu,  7 Nov 2019 17:42:37 +1300 (NZDT)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id A694228005F; Thu,  7 Nov 2019 17:42:37 +1300 (NZDT)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     broonie@kernel.org, kdasu.kdev@gmail.com,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH 0/2] spi: more GPIO CS work
Date:   Thu,  7 Nov 2019 17:42:33 +1300
Message-Id: <20191107044235.4864-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I've got a platform using the BCM 58525 CPU. The hardware design
connects to two SPI devices using a slightly odd arrangement of
GPIOs and native chip select. These patches however should be
relevant to any platform using that CPU with "normal" CS GPIOs

Chris Packham (2):
  spi: bcm-qspi: Convert to use CS GPIO descriptors
  spi: spi-mem: fallback to using transfers when CS gpios are used

 drivers/spi/spi-bcm-qspi.c | 7 +++++--
 drivers/spi/spi-mem.c      | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

--=20
2.24.0

