Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8408347FCE
	for <lists+linux-spi@lfdr.de>; Wed, 24 Mar 2021 18:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbhCXRwU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Mar 2021 13:52:20 -0400
Received: from mail-io1-f54.google.com ([209.85.166.54]:34526 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbhCXRvx (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Mar 2021 13:51:53 -0400
Received: by mail-io1-f54.google.com with SMTP id x16so22417072iob.1;
        Wed, 24 Mar 2021 10:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=17TKIF0QgDUzTxJGnuM465tbTrl6KEfcXDq37nKfdvc=;
        b=nshaLLuqQvChe4Mcer+IULnyq4fFJ2+nySWFhiYwRkP2u2/799swfvAEEPZYyX45hb
         Ldn5aZ6GhQ5SbCklM5P+mVFUV1JUU7JwHz5zPEw31BC6Wdgz3zCgpnc2DoIBGjfoZgN5
         Wfu3iCQV+JIbmT1yPlEDKzqWWRSjqQymrymFkzt9kQmADN7lt+j7p13+FInGHli42ofX
         tLQV7JN4MPmV2r79S6RqKD9Oi+fRTKMev7PyqrVYg6+NMAYIq51uNEgFGs1KI1aCGz0F
         ptYQtkIIVXipcSYUkUAzFSQV2diH7RF2UeVIlMddLUkMFAaofHSVjA/l7m2eiSPuzTBw
         hsAQ==
X-Gm-Message-State: AOAM533zpHDZvX8K+kSJ0zdvndDBxd4DCKUMPwgky84O6bhvRVXitGPb
        gcPGkwn70z0CwI3G8jv37w==
X-Google-Smtp-Source: ABdhPJx7hPRAeDLMlQ3t6S4EyGJIm+TvC3ilVZW8FSTOnuKiHnkj+ZxNsVYm6pnIJjby7DwcY3TeQA==
X-Received: by 2002:a02:a90f:: with SMTP id n15mr4000419jam.110.1616608312821;
        Wed, 24 Mar 2021 10:51:52 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id v17sm1361275ios.46.2021.03.24.10.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 10:51:52 -0700 (PDT)
Received: (nullmailer pid 3326340 invoked by uid 1000);
        Wed, 24 Mar 2021 17:51:49 -0000
Date:   Wed, 24 Mar 2021 11:51:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: spi: Convert Freescale DSPI to json schema
Message-ID: <20210324175149.GA3320002@robh.at.kernel.org>
References: <20210315121518.3710171-1-kuldeep.singh@nxp.com>
 <20210315183051.ugvmz4zqrvuo6iqq@ti.com>
 <067c42f3726578ebe60d201a141dfdb6@walle.cc>
 <20210316180655.6oidvffum7yuwknr@ti.com>
 <97410b24785492f9e80999dd7a1ffdea@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97410b24785492f9e80999dd7a1ffdea@walle.cc>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Mar 16, 2021 at 07:22:56PM +0100, Michael Walle wrote:
> Am 2021-03-16 19:06, schrieb Pratyush Yadav:
> > On 16/03/21 06:45PM, Michael Walle wrote:
> > > Am 2021-03-15 19:30, schrieb Pratyush Yadav:
> > > 
> > > ..
> > > > > +patternProperties:
> > > > > +  "@[0-9a-f]+":
> > > 
> > > Shouldn't this be "^.*@[0-9a-f]+$"?
> > 
> > The pattern has to match _anywhere_ in the string so both should match
> > the flash node. Your pattern is more "strict" or "precise". See the note
> > at [0].
> 
> I know, but specifying the whole line is widely used in the bindings.

It should be '@[0-9a-f]+$' which is equivalent to Michael's suggestion.

Rob
