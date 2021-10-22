Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB8BB437369
	for <lists+linux-spi@lfdr.de>; Fri, 22 Oct 2021 10:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbhJVIEE (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 22 Oct 2021 04:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231923AbhJVIEE (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 22 Oct 2021 04:04:04 -0400
X-Greylist: delayed 377 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Oct 2021 01:01:46 PDT
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a01:4f8:fff0:65::8:228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD41CC061764
        for <linux-spi@vger.kernel.org>; Fri, 22 Oct 2021 01:01:46 -0700 (PDT)
Received: from smtp.freedom.nl (unknown [10.10.3.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 5F00B51
        for <linux-spi@vger.kernel.org>; Fri, 22 Oct 2021 07:55:27 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [116.202.127.71]) by soverin.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=deathstar2.nl;
        s=soverin; t=1634889326;
        bh=5tJW6viw1A/bFkBz+tPPHpZ8d2MLoyW6fzoOk7LNjqs=;
        h=To:From:Subject:Date:From;
        b=a6ZsvTVHsqOGkMawELrEjpKPlreOausuD6tGHRbe778lWvAgMNihvHBwt+2ocvutX
         mNjBi8pvE8YdpR89cgzUCwBRGMAA/uWpUMIMAzYaSlNlOpZtePmJ9UdZ82u1bUCFrp
         sqa9bcQ6QcIQ6xmPUMi/e/TyYNWMj0ZsaDJpwKKzHXDesh0t1bWs475jN23NN3x6ti
         Bp/YXcwB6v1zBmsyTqYYwG3ywv0Ghsz2zqmLSNd/WcFD/veb5d8EJKBy1RYxAVH2fR
         vd68EGzD/9zlkXQHd6fBvBWefNi7r4GwQjEToYftH4+tvO0akf0+t69O0tAyn3V2jy
         v2k7kePOijJEg==
To:     linux-spi@vger.kernel.org
From:   Henk Medenblik <henk@deathstar2.nl>
Subject: spi enumeration process
Message-ID: <7247d1f3-552b-1e48-7fd6-e95edc12d016@deathstar2.nl>
Date:   Fri, 22 Oct 2021 09:55:23 +0200
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

