Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4B53E5783
	for <lists+linux-spi@lfdr.de>; Tue, 10 Aug 2021 11:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhHJJwz (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 10 Aug 2021 05:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhHJJwy (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 10 Aug 2021 05:52:54 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908A2C0613D3;
        Tue, 10 Aug 2021 02:52:31 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id n7so3186681ljq.0;
        Tue, 10 Aug 2021 02:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VxKLBzjOyzndQSkwMtQilthdPdFNiRTvzfca7De9zs4=;
        b=LgS5+341pmKDIZcJiTqLAxhlTc1fpnzWz8agEjGPUuZOFgPdIv5F3A22w1uUmldpVj
         RfFZf1w/CLKaYaDmNWuhZFqRTj8UqAbA7RXDgcr0hDhfiXt3WaWMey/qfaZXli+jyla5
         Ka/wMo9xCM/CRPzl4yKk1PdJec9YuhFIHNuFY69PCHDvScjlTxwC+RRr0XWPx6G8ofV3
         I/ozlE7hNWIul8IEhtoKPaUWBc3GwI7MwgwUYgkmOal4VVx0KPEnpLZYD3Mp07ykgMS0
         n/4z/47F+gZdLZrQomt8+DYIMQOVcIP8vpKPDPzagVIXJCsfJ9YBTG9ZvJigjmPYPQp5
         +U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VxKLBzjOyzndQSkwMtQilthdPdFNiRTvzfca7De9zs4=;
        b=P0C0eYzkms0ei/6Vr3ovw5UiVZSdgn30kvV7dWjm9I6zshJAQggDtN2DPID5cqBNWO
         HcBodxoSSeyoY5tILfU9RUqRtNAv6tBFEWR5U4E4yFh0tZAgozXWUm9GSJ9t78tdBYnf
         wI/oW+Y4YE6CANj1ootYKBVIQpzReiQvoMqEoKZjO+uWv0DQ+A0gx956PRAP+uhC55RW
         0uKKYm7YUHpne2yke7SmeVsuocvbm31vNhZrb+MT0ZvfyrO8I+3SvB8Kp9y3Ue7Qzj35
         Oak2tsXE1HQZk/f5P36UnrpnJSVfnXZud1ZmOFRNkgPjlC3j4FqYObqAceKsXSlkggeC
         vAqg==
X-Gm-Message-State: AOAM5304bUpAo+broKzx29IecAXZDithinPH9gcsOchMrCnzYvuA1NAK
        Agsd/5m/pN55Q1V84x9fGhM=
X-Google-Smtp-Source: ABdhPJwqa3xO06zcgzEnLHW1CMokvDfOYURj44goeGFArf00P9qfl4PCvw88u814T9NobtU74F30IA==
X-Received: by 2002:a05:651c:1119:: with SMTP id d25mr12859530ljo.129.1628589149962;
        Tue, 10 Aug 2021 02:52:29 -0700 (PDT)
Received: from mobilestation ([95.79.127.110])
        by smtp.gmail.com with ESMTPSA id v124sm1997031lfa.192.2021.08.10.02.52.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 02:52:29 -0700 (PDT)
Date:   Tue, 10 Aug 2021 12:52:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Srikandan, Nandhini" <nandhini.srikandan@intel.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mgross@linux.intel.com" <mgross@linux.intel.com>,
        "Pan, Kris" <kris.pan@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>,
        "Zhou, Furong" <furong.zhou@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>,
        "Vaidya, Mahesh R" <mahesh.r.vaidya@intel.com>,
        "A, Rashmi" <rashmi.a@intel.com>
Subject: Re: =?utf-8?B?W+KAnFBBVENI?= =?utf-8?B?4oCd?= 0/2] Add support for
 Intel Thunder Bay SPI
Message-ID: <20210810095227.ixukmo2gnq73bikj@mobilestation>
References: <20210722053358.29682-1-nandhini.srikandan@intel.com>
 <20210722160919.ccjfodb7pbvu7ul5@mobilestation>
 <BN0PR11MB5727CB650247519314CCC92785F79@BN0PR11MB5727.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN0PR11MB5727CB650247519314CCC92785F79@BN0PR11MB5727.namprd11.prod.outlook.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Aug 10, 2021 at 09:24:08AM +0000, Srikandan, Nandhini wrote:
> 
> 
> > -----Original Message-----
> > From: Serge Semin <fancer.lancer@gmail.com>
> > Sent: Thursday, July 22, 2021 9:39 PM
> > To: Srikandan, Nandhini <nandhini.srikandan@intel.com>
> > Cc: broonie@kernel.org; robh+dt@kernel.org; linux-spi@vger.kernel.org;
> > linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > mgross@linux.intel.com; Pan, Kris <kris.pan@intel.com>; Demakkanavar,
> > Kenchappa <kenchappa.demakkanavar@intel.com>; Zhou, Furong
> > <furong.zhou@intel.com>; Sangannavar, Mallikarjunappa
> > <mallikarjunappa.sangannavar@intel.com>; Vaidya, Mahesh R
> > <mahesh.r.vaidya@intel.com>; A, Rashmi <rashmi.a@intel.com>
> > Subject: Re: [“PATCH” 0/2] Add support for Intel Thunder Bay SPI
> > 
> > Hello Nandhini
> > 
> > On Thu, Jul 22, 2021 at 01:33:56PM +0800, nandhini.srikandan@intel.com
> > wrote:
> > > From: Nandhini Srikandan <nandhini.srikandan@intel.com>
> > >
> > > Hi,
> > >
> > > This patch set enables the support for Designware SPI on the Intel Thunder
> > Bay SoC.
> > >
> > > Patch 1: SPI DT bindings for Intel Thunder Bay SoC Patch 2: Adds
> > > support for Designware SPI on Intel Thunderbay SoC
> > >
> > > Please help to review this patch set.
> > 
> > Thanks for the patchset. I'll send you my comments to the corresponding
> > patches soon.
> > 

> Thank you for your review comments. I am working on it and I will share another patchset shortly. 

I'd suggest to answer on the review questions first...

-Sergey

> 
> Regards,
> Nandhini
> 
> > >
> > > Thanks & Regards,
> > > Nandhini
> > >
> > > Nandhini Srikandan (2):
> > >   dt-bindings: spi: Add bindings for Intel Thunder Bay SoC
> > >   spi: dw: Add support for Intel Thunder Bay SPI
> > >
> > >  .../bindings/spi/snps,dw-apb-ssi.yaml         |  2 ++
> > >  drivers/spi/spi-dw-core.c                     |  6 ++++++
> > >  drivers/spi/spi-dw-mmio.c                     | 20 +++++++++++++++++++
> > >  drivers/spi/spi-dw.h                          | 15 ++++++++++++++
> > >  4 files changed, 43 insertions(+)
> > >
> > > --
> > > 2.17.1
> > >
