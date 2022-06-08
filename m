Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CEC5435CB
	for <lists+linux-spi@lfdr.de>; Wed,  8 Jun 2022 17:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242083AbiFHPAK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 8 Jun 2022 11:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243796AbiFHO61 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 8 Jun 2022 10:58:27 -0400
Received: from smtp16.bhosted.nl (smtp16.bhosted.nl [IPv6:2a02:9e0:8000::27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC3D3ED16
        for <linux-spi@vger.kernel.org>; Wed,  8 Jun 2022 07:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=Sv+LKb0K45pAUtKWZjNiRz3hn9bdKxU+R/JutXHtSDw=;
        b=iGaC3vBfR0PpQa6JE/fx12aFw4UGfanK3aS0XKxBw3NlIXr48tMb0OKcMTLV+XGZ/BHNHMKGKOnlr
         vcIlNFUC+mChm81XKOVFG+ydle++d7fdlZQwqlkKuH7hXdac89DBT0fvJT0xLtp3XIn1zSTRy1DMvH
         qvGMW5EMR1blPq05gY5u+pqKmAfZnpzvNZ80v2GEWB4B0JlmwGjQY0llPum/64VOtM+D4wDeyEnR0F
         wFNb/aDEPEjC4kaej/x3j3PfPPY9L9MhvWydcILpJMFnPT3oewwI/9IjKnwWcIQsLG4TuAs5yA8mWQ
         Vw922bKV5jybG4fQscayqrTb6Fboq+A==
X-MSG-ID: 04660b35-e73b-11ec-9896-0050569d2c73
Date:   Wed, 8 Jun 2022 16:55:20 +0200
From:   David Jander <david@protonic.nl>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] [PATCH 3/3] drivers: spi: spi.c: Don't use the message
 queue if possible in spi_sync
Message-ID: <20220608165520.0ec0c31c@erd992>
In-Reply-To: <CAHp75VcsOmyuSbwJjrAgA-MB-i05WPKX7C-qDgusF_eZ4ak0cA@mail.gmail.com>
References: <20220525142928.2335378-1-david@protonic.nl>
        <20220525142928.2335378-4-david@protonic.nl>
        <CAHp75VcsOmyuSbwJjrAgA-MB-i05WPKX7C-qDgusF_eZ4ak0cA@mail.gmail.com>
Organization: Protonic Holland
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, 8 Jun 2022 15:43:22 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, May 26, 2022 at 2:46 AM David Jander <david@protonic.nl> wrote:
> >
> > The interaction with the controller message queue and its corresponding
> > auxiliary flags and variables requires the use of the queue_lock which is
> > costly. Since spi_sync will transfer the complete message anyway, and not
> > return until it is finished, there is no need to put the message into the
> > queue if the queue is empty. This can save a lot of overhead.
> >
> > As an example of how significant this is, when using the MCP2518FD SPI CAN
> > controller on a i.MX8MM SoC, the time during which the interrupt line
> > stays active (during 3 relatively short spi_sync messages), is reduced
> > from 98us to 72us by this patch.  
> 
> ...
> 
> > +       /* If another context is idling the device then wait */
> > +       while (ctlr->idling) {
> > +               printk(KERN_INFO "spi sync message processing: controller is idling!\n");  
> 
> printk() when we have a device pointer, why (despite of pr_info() existence)?

Sorry for that. I often use printk() explicitly to remind me of things that
need to get removed, but in this case I left this broken piece of code on
purpose for the discussion and immediately addressed it in a reply to this
patch (hence the RFC tag in the subject).
Thanks for being vigilant, and sorry for the noise.

> > +               usleep_range(10000, 11000);
> > +       }
> > +
> > +       was_busy = READ_ONCE(ctlr->busy);
> > +
> > +       ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
> > +       if (ret)
> > +               goto out;
> > +
> > +       if (!was_busy) {
> > +               kfree(ctlr->dummy_rx);
> > +               ctlr->dummy_rx = NULL;
> > +               kfree(ctlr->dummy_tx);
> > +               ctlr->dummy_tx = NULL;
> > +               if (ctlr->unprepare_transfer_hardware &&
> > +                   ctlr->unprepare_transfer_hardware(ctlr))
> > +                       dev_err(&ctlr->dev,
> > +                               "failed to unprepare transfer hardware\n");
> > +               spi_idle_runtime_pm(ctlr);
> > +       }  
> 

Best regards,

-- 
David Jander
