Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF3E7844A2
	for <lists+linux-spi@lfdr.de>; Tue, 22 Aug 2023 16:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbjHVOqI (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 22 Aug 2023 10:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjHVOqI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 22 Aug 2023 10:46:08 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5CB10B
        for <linux-spi@vger.kernel.org>; Tue, 22 Aug 2023 07:46:02 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E5261C0006;
        Tue, 22 Aug 2023 14:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692715561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4gZVmu0fHH4vV8Rf26Edu7HoTw2r3gICdYsCz8veCbw=;
        b=g13yOyxEdZ4r+OpCpXKXIs5U5X1ygeDBHxxzliFkXtOXVHkIhNI8shBD+JyQ5JUq7xY99r
        1kKQouhwC+WhcSi/dqXts3BJQcVUqQOYhW8Fq8wKj6Ct1lckVWQOXiIsIdWc5MhptH8ML2
        ImPjTVgkjD+19hfatiZASrm/n6w9kj3h1DC7d2Lvc4Ml96nMuzCAxZvoB+hN/eL1Eu0XHm
        DNxF6aYQMOl41JkOnbQkj9UFCcEGkb9E08s3IxvJfWkX55nOLGJIC0QpVhW7QMqMfKQVfy
        lFWidNdCtO5Rmm3zsRQ/NjiPBlub4oUB09pw4rML9wRpDFMvdSJtXjOuImMzaw==
Date:   Tue, 22 Aug 2023 16:45:55 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Jinjie Ruan <ruanjinjie@huawei.com>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Radu Pirea <radu_nicolae.pirea@upb.ro>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH -next] spi: at91-usart: Use PTR_ERR_OR_ZERO() to simplify
 code
Message-ID: <20230822144555d15b0dcd@mail.local>
References: <20230822124643.987079-1-ruanjinjie@huawei.com>
 <52e3a5df-41ae-db71-fe4c-f46db22db4c3@microchip.com>
 <b11438ee-e05e-473b-a95b-433444fc77e0@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b11438ee-e05e-473b-a95b-433444fc77e0@sirena.org.uk>
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 22/08/2023 15:15:13+0100, Mark Brown wrote:
> On Tue, Aug 22, 2023 at 03:11:01PM +0200, Nicolas Ferre wrote:
> 
> > Do we really need these changes?... oh well, no strong opinion but is it
> > worth the effort?
> 
> I tend to go on the basis that for this sort of thing that's recognised
> by pattern matching other people will end up sending versions of it no
> matter what.

And I'd love for people to explicitly write this has been automatically
generated in their commit log so we know that probably no though has
been given to the patch.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
