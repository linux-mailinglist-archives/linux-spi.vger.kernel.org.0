Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5053BDAA7
	for <lists+linux-spi@lfdr.de>; Wed, 25 Sep 2019 11:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732558AbfIYJMF (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 25 Sep 2019 05:12:05 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:34649 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732047AbfIYJME (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 25 Sep 2019 05:12:04 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 46dXPZ459qz1s1VD;
        Wed, 25 Sep 2019 11:12:02 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 46dXPZ3b8lz1qqkT;
        Wed, 25 Sep 2019 11:12:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id 8iThIo0qh6UY; Wed, 25 Sep 2019 11:12:01 +0200 (CEST)
X-Auth-Info: 4YZxQVGDFmdTAqclATY3eofxLYXXnWAyMLjj80NHdd0=
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 25 Sep 2019 11:12:01 +0200 (CEST)
From:   Lukasz Majewski <lukma@denx.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org, Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 0/2] spi: Fix problem with interrupted slave transmission
Date:   Wed, 25 Sep 2019 11:11:41 +0200
Message-Id: <20190925091143.15468-1-lukma@denx.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190924110547.14770-1-lukma@denx.de>
References: <20190924110547.14770-1-lukma@denx.de>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

This patch series fixes problem with recovering Vybrid's NXP DSPI
controller state after master transmission distortion.

It was tested with a setup where /dev/spidevX.Y devices were used in
a loopback mode (provided by proper HW connections). During this test
the distortion was introduced and the system was assessed if it is
possible to continue correct SPI transmission.

This series applies clearly on v5.2 (tag) and current mainline:
SHA1: 351c8a09b00b5c51c8f58b016fffe51f87e2d820

Lukasz Majewski (2):
  spi: Add call to spi_slave_abort() function when spidev driver is
    released
  spi: Introduce dspi_slave_abort() function for NXP's dspi SPI driver

 drivers/spi/spi-fsl-dspi.c | 20 ++++++++++++++++++++
 drivers/spi/spidev.c       |  3 +++
 2 files changed, 23 insertions(+)

-- 
2.20.1

