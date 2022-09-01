Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08625A9B5F
	for <lists+linux-spi@lfdr.de>; Thu,  1 Sep 2022 17:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiIAPRJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Sep 2022 11:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiIAPRI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Sep 2022 11:17:08 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665C85C344
        for <linux-spi@vger.kernel.org>; Thu,  1 Sep 2022 08:17:07 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id h13-20020a17090a648d00b001fdb9003787so2926475pjj.4
        for <linux-spi@vger.kernel.org>; Thu, 01 Sep 2022 08:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :organization:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=/WG2OFx929nCXH2ZM3PUDvkF6pJ+tt1HhQrqfir3hPE=;
        b=oxcTFm8Vwmz5O9M6BQufmytK7OmU1vIM9Wd6sUMYI2Wpde1L4SKVvEHl34+6tqHPVB
         BukJMi/H5MY7la1Uw8JLAxVAt5YtUWSTRpNSCMlucMx3Kl6BaAcF/JgvohhF3i6EdbGc
         aEbolaMwJMyAtLUbgmZIrLBIyTVZSH8NyK1GgsZV86+SBG2lqG5GjevWubruz/mE3M7G
         BWL53t/n0arLJ5mPn+wmfoR/uzJntLbxsz+++1jeTNgNKAh2eCBsiW7flD9e1oZNhHEV
         cmlsouXB8rlTHe1p0VIW8mpvxIEb9OcUgqZWDosrVh1vlBTh2hRBCJGnyTopZ58anssV
         zAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :organization:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=/WG2OFx929nCXH2ZM3PUDvkF6pJ+tt1HhQrqfir3hPE=;
        b=6Vtam/yoDI8hak1T6yqNAMdxCB75vMLC942J1+p5EJpTiF1lnXTMhC9lQe7FNuy2Nj
         n9214yXf9/8vuyz3jSWaVakOgUdOSJond1HrWOGsdt04ldcZYh2J812ut9CYOtXhip5o
         9WUF6D7JBsdm8PLElUnhbLVEQ2oSWX1g/YxMhcbz+wxrxI+P/fooc++f07sAgLNglycZ
         SHFs+WSnZOHm0vAVR29LDU/BeFDXs4nUl01kfbme9qLcrpi8WYNWh8Fy0tcWuw1SGYtQ
         X8at3UeUStvDFSF9iP/SQaEIVNhHf8CkhaZIkpLibTcZOwK4tTeoZN1QkZj9knSglGHk
         guYA==
X-Gm-Message-State: ACgBeo3QXwvmhoMb4DZkpZsN6JljRSfUbc1dvG1AV7VMkJyDia+/z7CE
        tkwMHdWc/QaNPz2INStW444=
X-Google-Smtp-Source: AA6agR7xdyUCHKDBGSrcdvhOCFoQrASKA+W6gepYFRu3Fd2aBkTrg/G/wJ3pZL1fAZJZou8h/5D2Lg==
X-Received: by 2002:a17:90b:2643:b0:1fb:707d:af1f with SMTP id pa3-20020a17090b264300b001fb707daf1fmr9340723pjb.7.1662045426719;
        Thu, 01 Sep 2022 08:17:06 -0700 (PDT)
Received: from wse-c0155 (static-193-12-47-89.cust.tele2.se. [193.12.47.89])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090a514500b001fb3aba374dsm3387757pjm.31.2022.09.01.08.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:17:06 -0700 (PDT)
Date:   Thu, 1 Sep 2022 17:16:54 +0200
From:   Casper Andersson <casper.casan@gmail.com>
To:     David Jander <david@protonic.nl>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Subject: Re: [PROBLEM] spi driver internal error during boot on sparx5
Message-ID: <20220901151654.naqa32vckuzvuoac@wse-c0155>
Organization: Westermo Network Technologies AB
References: <20220826094143.iysrl3tsqxmhp4dq@wse-c0155>
 <20220829105613.476622d2@erd992>
 <Yw+HTj98V1ToLWIL@sirena.org.uk>
 <YxBX4bXG02E4lSUW@axis.com>
 <20220901130222.587f4932@erd992>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901130222.587f4932@erd992>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

Thanks for the help and fixes. I did some testing with your patches. I
saw you already submitted the patches, but for reference here's my
results.

David's initial fix (changing async->sync):
no issues

Mark's fix:
no issues

David's second fix:
Issue still occurs. But does not cause any problems and together with
Mark's fix it works fine.

Best Regards,
Casper

On 2022-09-01 13:02, David Jander wrote:
> On Thu, 1 Sep 2022 08:57:37 +0200
> Vincent Whitchurch <vincent.whitchurch@axis.com> wrote:
> 
> > On Wed, Aug 31, 2022 at 05:07:42PM +0100, Mark Brown wrote:
> > > On Mon, Aug 29, 2022 at 10:56:13AM +0200, David Jander wrote:  
> > > > Not sure if this is a correct fix, but I'd like to know if your situation
> > > > changes this way, if you could try it.
> > > > I don't have access to any hardware with a mux unfortunately, so I can't test
> > > > it myself.  
> > > 
> > > I guess claiming to have a noop mux might work for testing, though I'd
> > > be dubious that it was actually doing the mux operations properly?  I  
> > 
> > I'm seeing these problems with the roadtest test framework which uses
> > UML and doesn't need any special hardware.  Roadtest puts its emulated
> > devices under a spi-mux with gpio-mockup and there are no tests for the
> > actual muxing, but other driver tests break since transfers using
> > spi-mux don't work properly.
> > 
> > I pushed the latest version with SPI support to the tree below.  The
> > test_adc084s021 tests a SPI device.  Roadtest is placed inside a linux
> > tree, but it doesn't need any patches to the kernel:
> > 
> >  https://github.com/vwax/linux/commits/roadtest/devel
> > 
> > You can reproduce the problem with:
> > 
> >  git remote add vwax https://github.com/vwax/linux.git
> >  git fetch vwax
> >  git archive vwax/roadtest/devel tools/testing/roadtest | tar xf -
> >  make -C tools/testing/roadtest/ -j24 OPTS="-k adc --rt-timeout 10 -v"
> > 
> > The test passes on v5.19 but on current mainline it hangs and times out.
> 
> This is very nice. Thanks.
> I followed your instructions, and if I apply the following, all tests are
> passed.
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 83da8862b8f2..32c01e684af3 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1727,8 +1727,7 @@ static void __spi_pump_messages(struct spi_controller *ctlr, bool in_kthread)
>         spin_unlock_irqrestore(&ctlr->queue_lock, flags);
>  
>         ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
> -       if (!ret)
> -               kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
> +       kthread_queue_work(ctlr->kworker, &ctlr->pump_messages);
>  
>         ctlr->cur_msg = NULL;
>         ctlr->fallback = false;
> 
> The problem is that if __spi_pump_transfer_message() fails, the ctlr->busy
> flag is left true, so __spi_async() is not going to queue new work. The busy
> transition is handled right above that piece of code, in
> __spi_pump_transfer_message(), and the mechanism is to queue more work to do
> it. Apparently work was only queued when the transfer was successful, and I am
> not sure why it was like that. Queuing work unconditionally solves the issue
> and should not be a problem.
> 
> Curious thing is, that this change alone is sufficient to make all the
> roadtest tests pass. But I still think that does not fix the bug reported by
> Casper. For that, Mark's patch is also necessary.
> 
> @Casper: can you test Mark's patch with above addition?
> 
> > > think we need to either change spi_mux to duplicate the incoming message
> > > (that's probably "cleaner") or teach the core that spi-mux exists and
> > > should always use the pump/queue.  The below might do the trick but in
> > > spite of my suggestion above I've not tested either yet:
> > > 
> > > diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
> > > index f5d32ec4634e..0709e987bd5a 100644
> > > --- a/drivers/spi/spi-mux.c
> > > +++ b/drivers/spi/spi-mux.c
> > > @@ -161,6 +161,7 @@ static int spi_mux_probe(struct spi_device *spi)
> > >  	ctlr->num_chipselect = mux_control_states(priv->mux);
> > >  	ctlr->bus_num = -1;
> > >  	ctlr->dev.of_node = spi->dev.of_node;
> > > +	ctlr->must_async = true;
> > >  
> > >  	ret = devm_spi_register_controller(&spi->dev, ctlr);
> > >  	if (ret)
> > > diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> > > index 1cfed874f7ae..88d48a105d3c 100644
> > > --- a/drivers/spi/spi.c
> > > +++ b/drivers/spi/spi.c
> > > @@ -4033,7 +4033,7 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
> > >  	 * guard against reentrancy from a different context. The io_mutex
> > >  	 * will catch those cases.
> > >  	 */
> > > -	if (READ_ONCE(ctlr->queue_empty)) {
> > > +	if (READ_ONCE(ctlr->queue_empty) && !ctlr->must_async) {
> > >  		message->actual_length = 0;
> > >  		message->status = -EINPROGRESS;
> > >  
> > > diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> > > index e6c73d5ff1a8..f089ee1ead58 100644
> > > --- a/include/linux/spi/spi.h
> > > +++ b/include/linux/spi/spi.h
> > > @@ -469,6 +469,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
> > >   *	SPI_TRANS_FAIL_NO_START.
> > >   * @queue_empty: signal green light for opportunistically skipping the queue
> > >   *	for spi_sync transfers.
> > > + * @must_async: disable all fast paths in the core
> > >   *
> > >   * Each SPI controller can communicate with one or more @spi_device
> > >   * children.  These make a small bus, sharing MOSI, MISO and SCK signals
> > > @@ -690,6 +691,7 @@ struct spi_controller {
> > >  
> > >  	/* Flag for enabling opportunistic skipping of the queue in spi_sync */
> > >  	bool			queue_empty;
> > > +	bool			must_async;
> > >  };
> > >  
> > >  static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)
> > > 
> > > Assuming that works out there'll be an extra test in the fast path but
> > > no sync operations, and a performance hit for spi-mux users.  Hopefully
> > > that works as well as it did before.  
> >[...]
> 
> Best regards,
> 
> -- 
> David Jander
> Protonic Holland.
