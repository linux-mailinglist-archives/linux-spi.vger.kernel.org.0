Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204A25600DF
	for <lists+linux-spi@lfdr.de>; Wed, 29 Jun 2022 15:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbiF2NJH (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 29 Jun 2022 09:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233717AbiF2NI7 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 29 Jun 2022 09:08:59 -0400
Received: from smtp28.bhosted.nl (smtp28.bhosted.nl [IPv6:2a02:9e0:8000::40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C884228736
        for <linux-spi@vger.kernel.org>; Wed, 29 Jun 2022 06:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=protonic.nl; s=202111;
        h=content-transfer-encoding:content-type:mime-version:references:in-reply-to:
         message-id:subject:cc:to:from:date:from;
        bh=E22hEsQQEhp8rllmIq6qsrG6cDBcu8vSFULr13J89jI=;
        b=WCEs7nL5WgRz6VD+/qp2xVYs9gP1qcrMDUKgiZu/qhlycsk07AqQy9ruenu0jrH+XhWvGEHERwSwE
         ijavQRd355tlDkF+mDhkzQeZ2jbRMfvnh6RxnGegY41fLUX3lPKYeG/0AVfLGXvrt76WiuZ+B8q1lm
         Zv2XbwLBIpDmiuE23RRjEQVmUXASaUlLflZ/tgT/GNb+4ttfpGRfV3r5RxtXiQtXGmquEmG7Deh5vV
         pVqAQ0WgZY65amOF2zkO3Q9jKuvi9jfDSj80itUCK8x9MQzrxWSQZby4V9kdnD/vWILdUx5cAOzmZd
         kvBNfpmjda0ASaVypGW1nbuYPK4gcHQ==
X-MSG-ID: 8b2b3cc4-f7ac-11ec-8a45-0050569d11ae
Date:   Wed, 29 Jun 2022 15:08:17 +0200
From:   David Jander <david@protonic.nl>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 03/11] spi: Lock controller idling transition inside
 the io_mutex
Message-ID: <20220629150817.159ee022@erd992>
In-Reply-To: <CAHp75VeHcdcRMYxsJ3At+YyFZEauDPp-+deXbsBpcqKdxaicfg@mail.gmail.com>
References: <20220621061234.3626638-1-david@protonic.nl>
        <20220621061234.3626638-4-david@protonic.nl>
        <CAHp75VeHcdcRMYxsJ3At+YyFZEauDPp-+deXbsBpcqKdxaicfg@mail.gmail.com>
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

On Tue, 21 Jun 2022 15:36:23 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Jun 21, 2022 at 8:15 AM David Jander <david@protonic.nl> wrote:
> >
> > This way, the spi sync path does not need to deal with the idling
> > transition.  
> 
> ...
> 
> > -       mutex_lock(&ctlr->io_mutex);
> >         ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
> >         mutex_unlock(&ctlr->io_mutex);
> >
> >         /* Prod the scheduler in case transfer_one() was busy waiting */  
> 
> >         if (!ret)
> >                 cond_resched();  
> 
> In the similar way
> 
> 
> ret = ...
> if (ret)
>   goto out_unlock;
> 
> mutex_unlock();
> cond_resched();
> return;

Trying to add this change as an incremental patch to the whole series now that
it hit linux-next, I am not so sure about how to do this, since this code has
changed:

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/spi/spi.c?id=dc3029056b02414c29b6627e3dd7b16624725ae9#n1729

I understand that the blank line at line 1730 should go after 1732, so that
the ret = ... and the if (!ret) kthread... are not separated by a blank line.

So far so good, but modifying the rest of the code into this "if (!ret)
goto..." idiom will mess that up, since the code in lines 1733 and 1734 is now
common to both paths, so the simplest way I see it is to move those two lines
in between the "ret = ..." and "if (!ret)...". Is that more desirable than not
having the "if (!ret) goto" idiom?

Code would look like this:

	ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
	ctlr->cur_msg = NULL;
	ctlr->fallback = false;
	if (!ret) {
		kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
		goto out_mutex;
	}

	mutex_unlock(&ctlr->io_mutex);

	/* Prod the scheduler in case transfer_one() was busy waiting */
	cond_resched();
	return;

out_unlock:
	spin_unlock_irqrestore(&ctlr->queue_lock, flags);
out_mutex:
	mutex_unlock(&ctlr->io_mutex);
}

Please advice: is this really more desirable to what it is now? Or can I
better leave it as is and only move the blank line?

> > +       return;
> > +
> > +out_unlock:
> > +       mutex_unlock(&ctlr->io_mutex);  
> 

Best regards,

-- 
David Jander
