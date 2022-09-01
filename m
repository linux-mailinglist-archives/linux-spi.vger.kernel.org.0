Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC60A5A8EE5
	for <lists+linux-spi@lfdr.de>; Thu,  1 Sep 2022 08:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbiIAG5m (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 1 Sep 2022 02:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIAG5l (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 1 Sep 2022 02:57:41 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55EACC31C
        for <linux-spi@vger.kernel.org>; Wed, 31 Aug 2022 23:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1662015460;
  x=1693551460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qnPJy17DUgKf0sYu7jHYil4AJ7Mdc2Je6flRNiSn4Es=;
  b=SkFqiZXtow0T5tGUfTaGrsjT400pw0Ao1xBttH+L8DsEK5O2WFf3slpp
   15wGmSjtLTWDOmYcQqbw1JLM1gDQqK1eaTUFshiFFXEqR8ySnNsyOtoYf
   AhA2znK4Z5MSPI4UwKQwdVmex+oIbw1ovg5PeKOwlUqTYMxRmTKudJzrw
   xCzuF4al4MFmKl+0sCSinRAUrebITGd4s0lfpLZ8APfFQhzjiQhbJ1f2L
   /kTJA3CTcNeVY6EryVBx/+g61Q69j7seCOSFa6GrtKbJXQLauY1Y8nPm5
   /bvtoI1E2wDruTe8+JvgzUWGVIOA/y+ccNF95B8pFtKqRASbwWWPlt/EG
   g==;
Date:   Thu, 1 Sep 2022 08:57:37 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Mark Brown <broonie@kernel.org>
CC:     David Jander <david@protonic.nl>,
        Casper Andersson <casper.casan@gmail.com>,
        <linux-spi@vger.kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Andrew Lunn <andrew@lunn.ch>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
Subject: Re: [PROBLEM] spi driver internal error during boot on sparx5
Message-ID: <YxBX4bXG02E4lSUW@axis.com>
References: <20220826094143.iysrl3tsqxmhp4dq@wse-c0155>
 <20220829105613.476622d2@erd992>
 <Yw+HTj98V1ToLWIL@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yw+HTj98V1ToLWIL@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Aug 31, 2022 at 05:07:42PM +0100, Mark Brown wrote:
> On Mon, Aug 29, 2022 at 10:56:13AM +0200, David Jander wrote:
> > Not sure if this is a correct fix, but I'd like to know if your situation
> > changes this way, if you could try it.
> > I don't have access to any hardware with a mux unfortunately, so I can't test
> > it myself.
> 
> I guess claiming to have a noop mux might work for testing, though I'd
> be dubious that it was actually doing the mux operations properly?  I

I'm seeing these problems with the roadtest test framework which uses
UML and doesn't need any special hardware.  Roadtest puts its emulated
devices under a spi-mux with gpio-mockup and there are no tests for the
actual muxing, but other driver tests break since transfers using
spi-mux don't work properly.

I pushed the latest version with SPI support to the tree below.  The
test_adc084s021 tests a SPI device.  Roadtest is placed inside a linux
tree, but it doesn't need any patches to the kernel:

 https://github.com/vwax/linux/commits/roadtest/devel

You can reproduce the problem with:

 git remote add vwax https://github.com/vwax/linux.git
 git fetch vwax
 git archive vwax/roadtest/devel tools/testing/roadtest | tar xf -
 make -C tools/testing/roadtest/ -j24 OPTS="-k adc --rt-timeout 10 -v"

The test passes on v5.19 but on current mainline it hangs and times out.

> think we need to either change spi_mux to duplicate the incoming message
> (that's probably "cleaner") or teach the core that spi-mux exists and
> should always use the pump/queue.  The below might do the trick but in
> spite of my suggestion above I've not tested either yet:
> 
> diff --git a/drivers/spi/spi-mux.c b/drivers/spi/spi-mux.c
> index f5d32ec4634e..0709e987bd5a 100644
> --- a/drivers/spi/spi-mux.c
> +++ b/drivers/spi/spi-mux.c
> @@ -161,6 +161,7 @@ static int spi_mux_probe(struct spi_device *spi)
>  	ctlr->num_chipselect = mux_control_states(priv->mux);
>  	ctlr->bus_num = -1;
>  	ctlr->dev.of_node = spi->dev.of_node;
> +	ctlr->must_async = true;
>  
>  	ret = devm_spi_register_controller(&spi->dev, ctlr);
>  	if (ret)
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 1cfed874f7ae..88d48a105d3c 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -4033,7 +4033,7 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
>  	 * guard against reentrancy from a different context. The io_mutex
>  	 * will catch those cases.
>  	 */
> -	if (READ_ONCE(ctlr->queue_empty)) {
> +	if (READ_ONCE(ctlr->queue_empty) && !ctlr->must_async) {
>  		message->actual_length = 0;
>  		message->status = -EINPROGRESS;
>  
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index e6c73d5ff1a8..f089ee1ead58 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -469,6 +469,7 @@ extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 ch
>   *	SPI_TRANS_FAIL_NO_START.
>   * @queue_empty: signal green light for opportunistically skipping the queue
>   *	for spi_sync transfers.
> + * @must_async: disable all fast paths in the core
>   *
>   * Each SPI controller can communicate with one or more @spi_device
>   * children.  These make a small bus, sharing MOSI, MISO and SCK signals
> @@ -690,6 +691,7 @@ struct spi_controller {
>  
>  	/* Flag for enabling opportunistic skipping of the queue in spi_sync */
>  	bool			queue_empty;
> +	bool			must_async;
>  };
>  
>  static inline void *spi_controller_get_devdata(struct spi_controller *ctlr)
> 
> Assuming that works out there'll be an extra test in the fast path but
> no sync operations, and a performance hit for spi-mux users.  Hopefully
> that works as well as it did before.

The above patch will fix the problem introduced by commit ae7d2346dc89
("spi: Don't use the message queue if possible in spi_sync"), but it's
not enough.

There is another bug introduced by the commit 69fa95905d40 ("spi: Ensure
the io_mutex is held until spi_finalize_current_message()") which the
above proposed patch does not fix.  After one SPI transfer fails the
next transfer via the spi-mux never gets to the parent bus.  The above
test_adc084s021 uses roadtest's flaky_bus feature to inject bus
failures.

Note that if you're backing the tree to these commits for testing,
there's another problem you'll run into.  Both these commits cause
crashes, and to fix those you have to cherry-pick commit 72c5c59b659d
("spi: Set ctlr->cur_msg also in the sync transfer case").

And the SPI tree where these patches are on was based on v5.19-rc1,
which has an unrelated problem with the IIO sysfs trigger which can also
cause hangs and which was fixed by commit 78601726d4a5 ("iio: trigger:
sysfs: fix use-after-free on remove"), although those hangs are rare, as
opposed to the SPI problems which happen every time.
