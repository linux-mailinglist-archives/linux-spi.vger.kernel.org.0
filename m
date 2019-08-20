Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDAA96AF1
	for <lists+linux-spi@lfdr.de>; Tue, 20 Aug 2019 22:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbfHTU4Q (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 20 Aug 2019 16:56:16 -0400
Received: from mail.gsat.us ([66.165.183.93]:37900 "EHLO mail.gsat.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729900AbfHTU4Q (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 20 Aug 2019 16:56:16 -0400
X-Greylist: delayed 539 seconds by postgrey-1.27 at vger.kernel.org; Tue, 20 Aug 2019 16:56:15 EDT
Received: from [192.168.0.8] (cpe-76-85-7-46.tx.res.rr.com [76.85.7.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mailgse.com (Postfix) with ESMTPSA id 0F7D21450121
        for <linux-spi@vger.kernel.org>; Tue, 20 Aug 2019 20:47:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gsat.us; s=default;
        t=1566334036; bh=RnF7vQiBESmBKafZ4q49lYJvBCjFDKPX3flZvSQqlrE=;
        h=To:From:Subject:Date;
        b=LwiQanaDBMwgfdZLveYCQflVkhdo+byjfQHIBoGF5kJS3w5CsyspvNkJHI90aSjdc
         T9T1sxdATzjZdjJ27oUdr3H1IjivR/NI/nZp58VFy0darthFnspX1Oi/PSra2MAeWG
         ErKiC09j0UmWmmhZZpQ3pnLuavLjxQSErJSd6Yxc=
To:     linux-spi <linux-spi@vger.kernel.org>
From:   Daniel Santos <daniel@gsat.us>
Subject: Is there a "spimon" anywhere? Also spi flash data rate question
Message-ID: <ccad9bc9-3a3a-142a-dfa7-1120ff5a5430@gsat.us>
Date:   Tue, 20 Aug 2019 15:44:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hello,

I'm having some trouble getting a Winbond W25Q128FV to operate faster
than 24MHz (it's supposed to do 50 reading and 100 for everything
else).  Is there some type of "spimon" project or patch set anywhere to
dump spi traffic via netlink or printk for debugging?

Also, I don't see anything in the spi-nor driver that indicates it will
do different commands at different speeds, is this accurate?  In the
case of these chips, I presume the strategy is just to use the lowest
speed?  Most traffic will be reading anyway.

These data sheets have a lot of very specific timing requirements for
various commands and I also don't see any place that such delays can be
coded for a given device -- am I overlooking something?  Thanks in advance!

Cheers,
Daniel
