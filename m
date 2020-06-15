Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A49A1F8CD2
	for <lists+linux-spi@lfdr.de>; Mon, 15 Jun 2020 06:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbgFOEGA (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 15 Jun 2020 00:06:00 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:50500 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbgFOEGA (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 15 Jun 2020 00:06:00 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8EB1183645;
        Mon, 15 Jun 2020 16:05:57 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1592193957;
        bh=eMCW7PIbDxUJ0FcUqX8/FsSKB37ozxh4wKeCG+90NVQ=;
        h=From:To:Cc:Subject:Date;
        b=Rxksg5HcVDUZRw81MSbWdLSoo42G6oN2pjqpO6+f3H8Tog0G18hKedQcfboLaR7fO
         48VuMk6dwL7A499XrXMYffefyMpzWkWPjT9cEHZOHRIsdu2/WmLRzGHh7UnIoW6Y/z
         GjrXr58L9BPvS6cXNkvgHufzLZaE8w/scfNhUwqDkJ26wVsm/tekQtJrP34Zc7pf3H
         pybOR0vw79/04L8D+6OgIm9OMpe2PV1dNsBFD/h6/OPN3nFeoJMVPecyYEt6fg4rK3
         cp4+mi+cXFnQPcEsXHzZSn/bn7Y3+vj5D+D33f2IprSbzT/K1clFRQyQMvKaZTznIJ
         hXI4/VJTMbd0w==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5ee6f3a50000>; Mon, 15 Jun 2020 16:05:57 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by smtp (Postfix) with ESMTP id 991EE13EDE4;
        Mon, 15 Jun 2020 16:05:56 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 4A8513411CF; Mon, 15 Jun 2020 16:05:57 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     broonie@kernel.org, kdasu.kdev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH 0/5] Improvements to spi-bcm-qspi
Date:   Mon, 15 Jun 2020 16:05:52 +1200
Message-Id: <20200615040557.2011-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This series of patches came from a single large Broadcom patch that
implements drivers for a number of their integrated switch chips. Mostly
this is just splitting the qspi driver into smaller parts and doesn't
include much original from me.

Mark Tomlinson (5):
  spi: bcm-qspi: Add support for setting BSPI clock
  spi: bcm-qspi: Improve debug reading SPI data
  spi: bcm-qspi: Do not split transfers into small chunks
  spi: bcm-qspi: Make multiple data blocks interrupt-driven
  spi: bcm-qspi: Improve interrupt handling

 drivers/spi/spi-bcm-qspi.c | 189 ++++++++++++++++++++++---------------
 drivers/spi/spi-bcm-qspi.h |   5 +-
 2 files changed, 115 insertions(+), 79 deletions(-)

--=20
2.27.0

