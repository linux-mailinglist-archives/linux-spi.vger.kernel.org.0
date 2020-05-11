Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0C51CE751
	for <lists+linux-spi@lfdr.de>; Mon, 11 May 2020 23:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbgEKVVc (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 11 May 2020 17:21:32 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:39054 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgEKVVc (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 11 May 2020 17:21:32 -0400
Received: by mail-oo1-f66.google.com with SMTP id c83so2265799oob.6;
        Mon, 11 May 2020 14:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BuN92xQKE1O2gCcfAoLZqAomgXd8adBPnCrmK9Ay5OI=;
        b=LmI/i3qQU1bAxWt7iSzv/cMoueAmtftdbjh/4qyJNRujK48UhYsWNjn6R+75JM6e2s
         wvQyaSzQ+p/XCLGeGkjh8SKn5y38sEOfYiAPEMzWpwbndqJZdLLKCogU3DHDILj/N5+u
         b285AsjmUEBcvY8X9ljkcPYJVGzbqEgHkYsxDgsCWtR5VEE5jQxUIzpF2A8heDJAaf+j
         T/hs63Hxe272MRuW1dYB+/TjHROS56mIF0ZBsNo5iQmZlxfuOsaLTjtp/j/hozXFYjPT
         NAUXWyQtaThRN4QDU/rYbcOpQiZQr+Rq86udUeQeYTP6jflahm8gxs1haWRBDh03KaTO
         HT0g==
X-Gm-Message-State: AGi0PuZsZm46d3paUfrhERGap3i4iAEVhXJ/subgcGp7UyLX8BN8o5xc
        KV/BnBpQgPw1qJL1sF9WRQ==
X-Google-Smtp-Source: APiQypLnylkh5RtyKnJucQVNptDtrvSqg94sFVspZqr+nL1wlN/fvMFck/XbwCiTrWyJMEwAhkexgA==
X-Received: by 2002:a4a:86cd:: with SMTP id y13mr6631353ooh.87.1589232090833;
        Mon, 11 May 2020 14:21:30 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 85sm4919969oie.17.2020.05.11.14.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 14:21:30 -0700 (PDT)
Received: (nullmailer pid 32549 invoked by uid 1000);
        Mon, 11 May 2020 21:21:29 -0000
Date:   Mon, 11 May 2020 16:21:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: spi: Convert UniPhier SPI controller to
 json-schema
Message-ID: <20200511212129.GA32453@bogus>
References: <1587720562-15293-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587720562-15293-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 24 Apr 2020 18:29:22 +0900, Kunihiko Hayashi wrote:
> Convert UniPhier SPI controller binding to DT schema format.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
> 
> Changes since v1:
> - Put "#address-cells" and "#size-cells" into the required list
> 
>  .../bindings/spi/socionext,uniphier-spi.yaml       | 57 ++++++++++++++++++++++
>  .../devicetree/bindings/spi/spi-uniphier.txt       | 28 -----------
>  2 files changed, 57 insertions(+), 28 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/socionext,uniphier-spi.yaml
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-uniphier.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
