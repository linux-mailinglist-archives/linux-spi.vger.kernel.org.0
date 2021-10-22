Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B004372FB
	for <lists+linux-spi@lfdr.de>; Fri, 22 Oct 2021 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhJVHpZ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Oct 2021 03:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhJVHpY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Oct 2021 03:45:24 -0400
X-Greylist: delayed 221 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Oct 2021 00:43:07 PDT
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a01:4f8:fff0:2d:8::215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD66C061764
        for <linux-spi@vger.kernel.org>; Fri, 22 Oct 2021 00:43:07 -0700 (PDT)
Received: from smtp.freedom.nl (unknown [10.10.3.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 5DD6261261
        for <linux-spi@vger.kernel.org>; Fri, 22 Oct 2021 07:43:05 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [116.202.127.71]) by soverin.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=deathstar2.nl;
        s=soverin; t=1634888584;
        bh=5tJW6viw1A/bFkBz+tPPHpZ8d2MLoyW6fzoOk7LNjqs=;
        h=To:From:Subject:Date:From;
        b=DFfAUuOULHaRMi5XEDv90J/H3A8dhPV9ZtCDg2GXxPJheN4Qq2MOlbYy+t7ux6ekU
         s7EQgC7uDUIY5vDSzpO2T7GURUyHzT3kfT9SxfoHZAnNKmDSTuj/XrQ78Q27+vyLcw
         6MyNyjlR5z2KydbF7+02gSBTUJhQjTb+gsGHyWJJOZwAKS+KqNMbDF4FnoJZb4G6Oo
         SfMYZT3xX/MrvESGpIGilwhbSzdBTWKm3Yr7iMaJSWgyunVbRaMbUoqmLNgdy2R3rq
         AfP2otZxTUO4yIkLqGU/HaPk6ihg1nGAiquxIgMHINNXXqLVjbO6OecnlwqurHXm2b
         wyGSbopMeNxwA==
To:     linux-spi@vger.kernel.org
From:   Henk Medenblik <henk@deathstar2.nl>
Subject: spi enumeration process
Message-ID: <752220aa-ebdb-20e5-84c3-bce3e4392ca2@deathstar2.nl>
Date:   Fri, 22 Oct 2021 09:43:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi all,

I am using a custom SPI controller which I created in my Xilinx MPSoC 
fpga part. On this custom spi controller bus I have one or more SPI 
devices (in my case a custom LTC6951 driver) connected in the devicetree 
under my spi controller.
Because the controller is custom, I wrote the SPI controller driver and 
also some slave device drivers which seem to work.
These drivers are both created as out of tree loadable modules.

My issue is that at boot of my SocFPGA I can see that my SPI controller 
driver is correctly loaded during the boot process but the spi slave 
driver which is connected to my controller does not get automatically 
loaded.
Therefore, I manually need to do a modprobe ltc6951.ko in my case before 
the LTC6951 slave in my case is up and running.

So, it seems like if I do not really understand the spi  slaves 
enumeration process or there is something else that I am missing here. I 
was under the assumption that the slaves automatically get enumerated 
(they are put as slaves under my controller inside the device tree) 
whenever it's master controller becomes alive.

Can anybody clarify this issue for me?

Tnx,

Henk

