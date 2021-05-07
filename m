Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72610375E9E
	for <lists+linux-spi@lfdr.de>; Fri,  7 May 2021 03:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbhEGB4o (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 6 May 2021 21:56:44 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:38073 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232025AbhEGB4o (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 6 May 2021 21:56:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UY.qlt1_1620352542;
Received: from B-X3VXMD6M-2058.local(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0UY.qlt1_1620352542)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 07 May 2021 09:55:43 +0800
To:     andriy.shevchenko@linux.intel.com
Cc:     broonie@kernel.org, linus.walleij@linaro.org,
        linux-spi@vger.kernel.org, thesven73@gmail.com
References: <YJP6QIl+jnjKPlRo@smile.fi.intel.com>
Subject: Re: [PATCH v1] spi: fix client driver can't register success when use
 GPIO as CS
Reply-To: xhao@linux.alibaba.com
From:   Xin Hao <xhao@linux.alibaba.com>
Message-ID: <83ab9b6c-8fb2-b053-ecb3-04230ca34e48@linux.alibaba.com>
Date:   Fri, 7 May 2021 09:55:41 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <YJP6QIl+jnjKPlRo@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi, Andy:

     Yes, i got gpio from ACPI, i have a question why not we can't keep 
same with the gpio get from dt, i think it is a bug,

it should be fixed.

     BTW, my platform is arm64,not intel.

-- 
Best Regards!
Xin Hao

