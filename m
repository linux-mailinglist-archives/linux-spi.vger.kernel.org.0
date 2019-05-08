Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65A8618076
	for <lists+linux-spi@lfdr.de>; Wed,  8 May 2019 21:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727410AbfEHTbN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-spi@lfdr.de>); Wed, 8 May 2019 15:31:13 -0400
Received: from 212-186-180-163.static.upcbusiness.at ([212.186.180.163]:36196
        "EHLO cgate.sperl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfEHTbN (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 May 2019 15:31:13 -0400
Received: from msmac.intern.sperl.org (account martin@sperl.org [10.10.10.11] verified)
  by sperl.org (CommuniGate Pro SMTP 6.2.1 _community_)
  with ESMTPSA id 7764429; Wed, 08 May 2019 19:31:10 +0000
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: SPI regression with today's build
From:   kernel@martin.sperl.org
In-Reply-To: <515AD7AA-19E4-4DBF-8AAB-5EE8071FCAF6@martin.sperl.org>
Date:   Wed, 8 May 2019 21:31:22 +0200
Cc:     linux-spi <linux-spi@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <3B6A48E5-87AF-430A-A916-AD97662F90A9@martin.sperl.org>
References: <5be80c08e0873ab200ed472b98ea8772666852ff.camel@suse.de> <a2f71bcab3756dc35385288ca3287af6849933a6.camel@suse.de> <0f0b3e3c-93c4-b76c-854c-6f498bc017d6@tronnes.org> <515AD7AA-19E4-4DBF-8AAB-5EE8071FCAF6@martin.sperl.org>
To:     =?utf-8?Q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
X-Mailer: Apple Mail (2.3124)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


> On 08.05.2019, at 21:11, kernel@martin.sperl.org wrote:
> 
> As per (intended) api finalize_current_message should be called before
> finalize current message, as all sorts of reordering may occur and data
> may get moved arround.
> 
> For example you could even transform a spi_write_then_read into a single
> spi_transfer using a buffer and then copy the data back to the original
> place, whioch would not be supported as is.
> 
> In the end it may even make sense to make the dma-mapping also a
> spi resource transformation at the right place and move spi_res_release
> before the finalize current message.
> 
> But obviously that is a bigger change to core we may not be able to
> get into the current release window.

Something like this (compiles but untested) could solve the issue:

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5e75944ad5d1..002acfee7785 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1183,8 +1183,6 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,

        spi_finalize_current_message(ctlr);

-       spi_res_release(ctlr, msg);
-
        return ret;
 }

@@ -1448,6 +1446,8 @@ void spi_finalize_current_message(struct spi_controller *ctlr)
                }
        }

+       spi_res_release(ctlr, mesg);
+
        spin_lock_irqsave(&ctlr->queue_lock, flags);
        ctlr->cur_msg = NULL;
        ctlr->cur_msg_prepared = false;


It also fixes a memory leak (spi_res objects) when:
* bus_drivers call spi_finalize_current_message on its own
* prepare_message fails
* spi_map_msg fails

Then those resource transformations are not reverted and
memory is not freed.

@Nicolas: maybe you can confirm that this fixes your issue.

@Marc: you need to decide on if this is acceptable, but as
it is fixing actual memory leaks there may be a good argument
to apply it. But then as it is at the core longer testing would
be welcome...

Martin
