Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0310619A88
	for <lists+linux-spi@lfdr.de>; Fri, 10 May 2019 11:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfEJJXb (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Fri, 10 May 2019 05:23:31 -0400
Received: from www3345.sakura.ne.jp ([49.212.235.55]:27611 "EHLO
        www3345.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbfEJJXb (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Fri, 10 May 2019 05:23:31 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x4A9NIu5072302;
        Fri, 10 May 2019 18:23:18 +0900 (JST)
        (envelope-from na-hoan@jinso.co.jp)
Received: from www3345.sakura.ne.jp (49.212.235.55)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp);
 Fri, 10 May 2019 18:23:18 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav301.sakura.ne.jp)
Received: from [192.168.1.8] (p14010-ipadfx41marunouchi.tokyo.ocn.ne.jp [61.118.107.10])
        (authenticated bits=0)
        by www3345.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x4A9NH6T072290
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 10 May 2019 18:23:18 +0900 (JST)
        (envelope-from na-hoan@jinso.co.jp)
Subject: Re: [PATCH] spi: bcm2835: Remove spi_alloc_master() error printing
To:     Stefan Wahren <stefan.wahren@i2se.com>, broonie@kernel.org,
        linux-rpi-kernel@lists.infradead.org, eric@anholt.net
Cc:     linux-spi@vger.kernel.org
References: <1557477738-20634-1-git-send-email-na-hoan@jinso.co.jp>
 <f8998234-1ab6-43e7-7dd8-859933b2179f@i2se.com>
From:   Hoan <na-hoan@jinso.co.jp>
Message-ID: <a16cd122-8f30-d9d3-6774-bb6c25243f8c@jinso.co.jp>
Date:   Fri, 10 May 2019 18:23:17 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <f8998234-1ab6-43e7-7dd8-859933b2179f@i2se.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Dear Mr. Stefan!

On 2019/05/10 18:05, Stefan Wahren wrote:
> Hi,
>
> On 10.05.19 10:42, Nguyen An Hoan wrote:
>> From: Hoan Nguyen An <na-hoan@jinso.co.jp>
>>
>> Printing an error on memory allocation failure is unnecessary,
>> as the memory allocation core code already takes care of that.
>>
>> Signed-off-by: Hoan Nguyen An <na-hoan@jinso.co.jp>
> looks like more spi drivers are affected.
>
> Could you please take care at least of spi-bcm2835aux ?
Thanks! I have just updated it!


Thank You!

