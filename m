Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 011A9183952
	for <lists+linux-spi@lfdr.de>; Thu, 12 Mar 2020 20:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgCLTRk (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 12 Mar 2020 15:17:40 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34792 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgCLTRk (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 12 Mar 2020 15:17:40 -0400
Received: by mail-ot1-f68.google.com with SMTP id j16so7509586otl.1;
        Thu, 12 Mar 2020 12:17:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hd21tx8Q98roPfOH6LhR20KwY0U6rAJTkIh4maqUe/M=;
        b=tF4+UlySQK9fk1be5Dxp7a8cvo6liyZ54AMwJ/9kakHt4uc17/WnBv5jllZ/aHVUOu
         6UojVapQ+fWswSoVqOy2DB3YAmfulyv+vNv/KVA0UGueWKqlDks2yEjI24FLYy2CS0/i
         pvsQPDtaBYy7wNgVoLdhqFxj5L5LOC93wfRRimbEQgYuqdpjfsi+Uu9JWz2xk9W1gVKK
         GlR88hPdHLHtQ+dGAZ+VNkTXccElkHRG7Dl/fTVcJdMnXlSmVPPVPIGRORN7Tfp/jKq8
         IVvAl1FW3BND7H/b0k/7XmVT7Lxq3GRoO+g27s/phVFoo5UKC3Cqrik3AcvXTkyBWrGm
         pQfA==
X-Gm-Message-State: ANhLgQ3uWLYpkpBnNX7I4mbIw1lEZo46kqP+v85iW3QvLp1+wrqSIz6X
        3/wRlcFz7Rn73SunABTN1Q==
X-Google-Smtp-Source: ADFU+vspFHk47a5o9XBHxgyTVqmKFkvmz7PWngFVdlZqCUssDvxYhcc4V8uIJqJwJ6RGpki4SQQyQA==
X-Received: by 2002:a9d:734f:: with SMTP id l15mr1007301otk.55.1584040658124;
        Thu, 12 Mar 2020 12:17:38 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l4sm6149840oti.65.2020.03.12.12.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 12:17:37 -0700 (PDT)
Received: (nullmailer pid 15919 invoked by uid 1000);
        Thu, 12 Mar 2020 19:17:36 -0000
Date:   Thu, 12 Mar 2020 14:17:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Mark Brown <broonie@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v3 2/2] spi: dt-bindings: spi-controller: Fix
 spi-[rt]x-bus-width for slave mode
Message-ID: <20200312191736.GA15869@bogus>
References: <20200306085038.8111-1-geert+renesas@glider.be>
 <20200306085038.8111-3-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306085038.8111-3-geert+renesas@glider.be>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri,  6 Mar 2020 09:50:38 +0100, Geert Uytterhoeven wrote:
> The descriptions for the spi-rx-bus-width and spi-tx-bus-width
> properties refer to "MISO" and "MOSI", which are not explained in the
> document.  While these abbreviations are fairly common when talking
> about SPI, and thus may not need an explanation, they are not entirely
> correct in this context, as the SPI controller may be used in slave mode
> instead of master mode.
> 
> Fix this by replacing them by "read transfers" resp. "write transfers",
> like is done for the spi-rx-delay-us and spi-tx-delay-us properties.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v3:
>   - No changes,
> 
> v2:
>   - New.
> 
> This issue was present in the .txt version of the bindings, too, so
> technically it needs
> Fixes: a8830cb19cfea04e ("spi: Document DT bindings for SPI controllers in slave mode")
> but of course it won't apply to that version.
> ---
>  Documentation/devicetree/bindings/spi/spi-controller.yaml | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
