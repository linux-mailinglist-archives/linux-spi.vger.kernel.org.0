Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA8862BF6E
	for <lists+linux-spi@lfdr.de>; Wed, 16 Nov 2022 14:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233106AbiKPN2f (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 16 Nov 2022 08:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbiKPN1y (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 16 Nov 2022 08:27:54 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C54611455
        for <linux-spi@vger.kernel.org>; Wed, 16 Nov 2022 05:27:52 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id be13so29519327lfb.4
        for <linux-spi@vger.kernel.org>; Wed, 16 Nov 2022 05:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDj0stbzSMd9eBIshqi4L+ImvMwOfKAY+XleyVyBeF4=;
        b=pIvAU19X1CSTQpDAvEpA2lCyo5n1RFO7cqmffuzPtVqXwFAjr6Ep7msQqC7n6NbCDp
         D5X+sIiIIkCw9iILylqz2BA6ANEIcKm7K0bRjO9I+DU7aindrN83vDnPJ5MxWiDR07X/
         b+t8mEUJzL/zZzlpYhk3VhXWf1LlfYVD1hdWoSj5KZLkms+r2VBN+roMNJ5gX9l7EXkP
         tXDfycfe2/VPir7wwXHcpjPWUR5t3s6diLsOJuAEh6yz4x+EFx9guZa4qiWTrvQoi4sp
         o9CDl3/+A5fFuo9JsNkSvTE1CArSO/3zdUNNRQqqdt0266Vduu9Kp6YefHvBGJ55c5fp
         t8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDj0stbzSMd9eBIshqi4L+ImvMwOfKAY+XleyVyBeF4=;
        b=jktM5tNHRwG4yaA2S9ez1g8ix6Hwe4blsAfBh3pdmzouQeZMuvaujPQH0kc2IPpHcu
         oWPc3jejScDXvtwdDsxU75MLrTwfdexsynpO4t5BfVxyH/7FmfVT1Hh/jNQmzLGv2hvl
         HLsn6MbF2++SePVBd1MgiqNAfo4oU0Gm8teyjp7k9GqGwTKVZo+sCWTqJ7B6OM2ze/kw
         5oBJzQlc5m9ijJST4kE+HsGX4uIFAc9sNCMekFusjRVE7+c2LWnFzhS/VBkTH9sYiDkA
         ndVujH1/Dr6nwpYnUyYTrNVi15UwokS1TCSJC5I1c5FsQnctz5JViteqUp/PZ4srGAbL
         NCqA==
X-Gm-Message-State: ANoB5pkOuPZYGOOvOJD40eKqMX2ZlbCxA0NrS4MtXNRl767A3iSOVYuN
        yeNFCNLIiva9LvTfwR3nhjs=
X-Google-Smtp-Source: AA0mqf4ASe7lelnwrrLFbIfMqPInONW0ecHKItl/D7a4sJupSglIrb22wAxKGqBTWq4BBVqBYroIXg==
X-Received: by 2002:a19:f703:0:b0:4aa:a6f8:f042 with SMTP id z3-20020a19f703000000b004aaa6f8f042mr6649185lfe.405.1668605269112;
        Wed, 16 Nov 2022 05:27:49 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id a18-20020a056512391200b004b097f2c73dsm2593215lfu.253.2022.11.16.05.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 05:27:48 -0800 (PST)
Date:   Wed, 16 Nov 2022 16:27:46 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     broonie@kernel.org, feng.tang@intel.com,
        linus.walleij@stericsson.com, linux-spi@vger.kernel.org,
        yangyingliang@huawei.com
Subject: Re: [PATCH] spi: dw-dma: decrease reference count in
 dw_spi_dma_init_mfld()
Message-ID: <20221116132746.tbkdxuptgfxvvrki@mobilestation>
References: <20221116093204.46700-1-wangxiongfeng2@huawei.com>
 <20221116111921.a3lnx7wgufukfass@mobilestation>
 <dddf25a0-60f0-64d8-5002-2de15fe428e8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dddf25a0-60f0-64d8-5002-2de15fe428e8@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Nov 16, 2022 at 08:46:07PM +0800, Xiongfeng Wang wrote:
> Hi Serge,
> 
> On 2022/11/16 19:19, Serge Semin wrote:
> > Hi Xiongfeng,
> > 
> > On Wed, Nov 16, 2022 at 05:32:04PM +0800, Xiongfeng Wang wrote:
> >> pci_get_device() will increase the reference count for the returned

> >> pci_dev. Since 'dma_dev' is only used to filter the channel in
> >> dw_spi_dma_chan_filer(). After using it, we need to use pci_dev_put() to
> >                          ^               ^            ^
> >                          |               |            |
> >                       drop the dot and comma          s/use/call
> > 
> > * Although this could be fixed by Mark on merging the patch in.
> 
> Thanks for your reply !  Sorry, I am not so sure about the modification.
> Let me make sure it and send another version.
> Do you mean change it like below:
> 
>   dw_spi_dma_chan_filer(), we need to use pci_dev_put() to

I meant that the sentence should have looked like this:
"Since 'dma_dev' is only used to filter the channel in
dw_spi_dma_chan_filer() after using it we need to call pci_dev_put()
to decrease the reference count."

Though on the second thought the whole message sounds a bit clumsy
since with no driver internals knowledge a reader won't be able figure
out a link between the pci_get_device(), dw_spi_dma_init_mfld() and
dw_spi_dma_chan_filer() methods. I would convert it to something like
this:

+ [PATCH v2] spi: dw-dma: Fix PCI device reference count leak
+ 
+ The pci_get_device() method returns a pointer to a PCI device with
+ the incremented reference count. Since the pointer is defined and used
+ within the dw_spi_dma_init_mfld() function only we must decrement the
+ device reference count before exiting from the function otherwise the
+ count state will be unbalanced afterwards. Note it must be done for
+ both normal and error paths of the function.

Anyway the solution looks good to me. So don't forget to add my ab-tag
to v2 of the patch (if you intend to send one).

-Sergey

> 
> Thanks,
> Xiongfeng
> 
> > 
> >> decrease the reference count. Also add pci_dev_put() for the error case.
> >>
> >> Fixes: 7063c0d942a1 ("spi/dw_spi: add DMA support")
> >> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> > 
> > Nice catch. Thanks for the patch.
> > Acked-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > -Sergey
> > 
> >> ---
> >>  drivers/spi/spi-dw-dma.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
> >> index 1322b8cce5b7..ababb910b391 100644
> >> --- a/drivers/spi/spi-dw-dma.c
> >> +++ b/drivers/spi/spi-dw-dma.c
> >> @@ -128,12 +128,15 @@ static int dw_spi_dma_init_mfld(struct device *dev, struct dw_spi *dws)
> >>  
> >>  	dw_spi_dma_sg_burst_init(dws);
> >>  
> >> +	pci_dev_put(dma_dev);
> >> +
> >>  	return 0;
> >>  
> >>  free_rxchan:
> >>  	dma_release_channel(dws->rxchan);
> >>  	dws->rxchan = NULL;
> >>  err_exit:
> >> +	pci_dev_put(dma_dev);
> >>  	return -EBUSY;
> >>  }
> >>  
> >> -- 
> >> 2.20.1
> >>
> > .
> > 
