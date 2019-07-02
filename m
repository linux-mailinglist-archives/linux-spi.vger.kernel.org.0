Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB63B5CA0E
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2019 09:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbfGBHql (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jul 2019 03:46:41 -0400
Received: from salem.gmr.ssr.upm.es ([138.4.36.7]:34320 "EHLO
        salem.gmr.ssr.upm.es" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGBHqk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jul 2019 03:46:40 -0400
X-Greylist: delayed 325 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jul 2019 03:46:39 EDT
Received: by salem.gmr.ssr.upm.es (Postfix, from userid 1000)
        id 2C662AC053B; Tue,  2 Jul 2019 09:41:10 +0200 (CEST)
Date:   Tue, 2 Jul 2019 09:41:10 +0200
From:   "Alvaro G. M." <alvaro.gamez@hazent.com>
To:     linux-spi@vger.kernel.org,
        Ricardo Ribalda <ricardo.ribalda@gmail.com>
Subject: spi: xilinx: Reversion detected on userspace SPI 
Message-ID: <20190702074108.GA19191@salem.gmr.ssr.upm.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi

I've found that commit 5a1314fa697fc65cefaba64cd4699bfc3e6882a6 causes
userspace spi transfers to fail.

I've got a custom FPGA board with an Artix7 FPGA fitting a xilinx SPI core
attached to a Texas Instruments ADC. To configure this device I added a
compatible string on spidev.c and defined this device in the device tree,
so I get a /dev/spidev1.0 device.

A userspace application opens this device and performs SPI transfers using
the ioctl based interface.

When commit 5a1314fa697fc65cefaba64cd4699bfc3e6882a6 is applied, any write I
do is answered with the error message this patch introduces:

spidev spi1.0: Detected stall. Check C_SPI_MODE and C_SPI_MEMORY                       
spidev spi1.0: SPI transfer failed: -5                                                 
spi_master spi1: failed to transfer one message from queue                             

Reverting this commit restores things back and allows me to configure the ADC.

I can provide as much debug info as needed and can test whetever, but I
don't own a spi-nor flash that would trigger the error that Ricardo tried to
solve with his patch, so I couldn't test that my issue and his issue are
both solved simultaneously.

Best regards




-- 
Alvaro G. M.
