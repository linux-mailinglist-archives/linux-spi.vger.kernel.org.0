Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A99018047
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 21:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfEHTLu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 8 May 2019 15:11:50 -0400
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:36184
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfEHTLu (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 15:11:50 -0400
Received: from msmac.intern.sperl.org (account martin@sperl.org [10.10.10.11] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7764428; Wed, 08 May 2019 19:11:43 +0000
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: SPI regression with today's build
From:   kernel@martin.sperl.org
In-Reply-To: <0f0b3e3c-93c4-b76c-854c-6f498bc017d6@tronnes.org>
Date:   Wed, 8 May 2019 21:11:54 +0200
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        broonie@kernel.org, linux-spi@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <515AD7AA-19E4-4DBF-8AAB-5EE8071FCAF6@martin.sperl.org>
References: <5be80c08e0873ab200ed472b98ea8772666852ff.camel@suse.de> <a2f71bcab3756dc35385288ca3287af6849933a6.camel@suse.de> <0f0b3e3c-93c4-b76c-854c-6f498bc017d6@tronnes.org>
To:     =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


> On 08.05.2019, at 19:33, Noralf Trønnes <noralf@tronnes.org> wrote:
> 
> [cc:Martin]
> 
> Den 08.05.2019 19.07, skrev Nicolas Saenz Julienne:
>> Small follow-up on this, and CCing Noralf as I forgot to add him on the last
>> e-mail.
>> 
>> On Wed, 2019-05-08 at 17:01 +0200, Nicolas Saenz Julienne wrote:
...
>> It seems the SPI controller thread is racing with the device's thread.
>> Something like this:
>> 
>>     SPI Controller Thread                       SPI Device Thread
>> 
>> 					    -> spi_sync_transfer() creates
>> 					       spi_message on stack then
>> 					       sleeps until finished
>> 
>> 			[SPI transfer happens...]
>> 
>> -> spi_finalize_current_message()
>>   which wakes up SPI Device Thread
>> 
>>                                            -> spi_sync_transfer() returns, the
>> 					       message disapears from the stack
>> 
>> -> spi_res_release() there is no more
>>   spi_message and the memory is
>>   potentialy used for something else
>> 
>> I've been looking at the spi_split_transfers_maxsize() code and can't think of
>> a reason why spi_res_release() couldn't be placed before
>> spi_finalize_current_message(). Which would solve the issue, but I guess Noralf
>> has a better perspective on the topic.
>> 
> 
> The problem was that spi_res_release() restored the original transfers
> before spi_unmap_msg() is called in spi_finalize_current_message() thus
> dma unmapping the original transfers, not the split ones that was mapped.
> 
> This is the accompanying change to the driver that hasn't been applied:
> [v5,3/4] spi/spi-bcm2835: Split transfers that exceed DLEN
> https://patchwork.kernel.org/patch/10899587/
> 
> Unless Martin Sperl, who wrote spi_split_transfers_maxsize(), has other
> suggestions, I think we should just revert this patch.

As per (intended) api finalize_current_message should be called before
finalize current message, as all sorts of reordering may occur and data
may get moved arround.

For example you could even transform a spi_write_then_read into a single
spi_transfer using a buffer and then copy the data back to the original
place, whioch would not be supported as is.

In the end it may even make sense to make the dma-mapping also a
spi resource transformation at the right place and move spi_res_release
before the finalize current message.

But obviously that is a bigger change to core we may not be able to
get into the current release window.

Martin

