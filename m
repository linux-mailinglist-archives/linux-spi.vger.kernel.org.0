Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73803263799
	for <lists+linux-spi@lfdr.de>; Wed,  9 Sep 2020 22:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgIIUlW (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 9 Sep 2020 16:41:22 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35828 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgIIUlV (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 9 Sep 2020 16:41:21 -0400
Received: by mail-io1-f67.google.com with SMTP id r9so4704328ioa.2;
        Wed, 09 Sep 2020 13:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TqGCn7DWU7EUWxs9MN7C6bAa7Y406Cxeb7CwfmoBTx8=;
        b=TI0NHSIHMJFHExyeU451DF8wQ1+UR9ud9jGgn0FymFFL6uMxEM7X6VXeOzyBVTuZ3O
         K/lwbit8kSbys2UaZnRgSzKgjydeYTGbkPFa3nT4WGbfy9HBroDJeZ+8iU/TgRwOowGl
         bTk8baED1z/T+CSc5g+1oQJO19foZRpzhYAU/xmORrFJd5tg2lc4MaZ5nhy96S+cgqHc
         Hntk7LuvNfO7STL3Cnc9gmmHzVjUwo9TOuGjlueviEVzW+PA1NYfZ0u11506/ixeE/9J
         KTGaVw9uY/Kgg9lpzmC+4svbXbpLJuPJ382wZCrX7449tA7yeW3gbkTlsARMsnvM7LPZ
         nWpw==
X-Gm-Message-State: AOAM5332dblCNZHaXrdeixktH1wMzuhYut5KTrd/2hEMPRi5hHIDgeyN
        nrLwCOsZ+3oX9AwpdKF9Zw==
X-Google-Smtp-Source: ABdhPJwLwHtwzJ4ltje++kfY0TsTVaRVw7sQGbyuMO1IGirxuMWUNGgGKRpRaaeQayPrx++zVhyynQ==
X-Received: by 2002:a6b:6a01:: with SMTP id x1mr4975232iog.1.1599684080072;
        Wed, 09 Sep 2020 13:41:20 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id 64sm2085891ilv.0.2020.09.09.13.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 13:41:19 -0700 (PDT)
Received: (nullmailer pid 3041579 invoked by uid 1000);
        Wed, 09 Sep 2020 20:41:11 -0000
Date:   Wed, 9 Sep 2020 14:41:11 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Yendapally Reddy Dhananjaya Reddy 
        <yendapally.reddy@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:SPI SUBSYSTEM" <linux-spi@vger.kernel.org>,
        "maintainer:BROADCOM SPI DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-arm-kernel@lists.infradead.org,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 1/5] dt-bindings: spi: Fix spi-bcm-qspi compatible
 ordering
Message-ID: <20200909204111.GA3041530@bogus>
References: <20200827181842.1000451-1-f.fainelli@gmail.com>
 <20200827181842.1000451-2-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827181842.1000451-2-f.fainelli@gmail.com>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Thu, 27 Aug 2020 11:18:38 -0700, Florian Fainelli wrote:
> The binding is currently incorrectly defining the compatible strings
> from least specific to most specific instead of the converse. Re-order
> them from most specific (left) to least specific (right) and fix the
> examples as well.
> 
> Fixes: 5fc78f4c842a ("spi: Broadcom BRCMSTB, NSP, NS2 SoC bindings")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/spi/brcm,spi-bcm-qspi.txt           | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
