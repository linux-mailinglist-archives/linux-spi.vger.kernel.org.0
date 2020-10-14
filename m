Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33C0A28E173
	for <lists+linux-spi@lfdr.de>; Wed, 14 Oct 2020 15:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731209AbgJNNis (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Oct 2020 09:38:48 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:38316 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgJNNir (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Oct 2020 09:38:47 -0400
Received: by mail-oi1-f193.google.com with SMTP id h10so3247484oie.5;
        Wed, 14 Oct 2020 06:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=89Wbh7NOqrYtjG7EOrNe0efzcrAmJCrw/e2mH3XntUg=;
        b=hMe5rSJazmkuwm3NWH7CGBvO1kYYbxz8UUkSgp3PVmF2y9P7qY/ysIYMTSuwYyo61u
         LgCEsNDwZ1LnbrCPS792EmS1QLszMkKVNGlGBDWubD32iBOGHidPiVPSJzAQKaLLPkGB
         xCzxKRy65leUHGKXbvELi482sCqfDmGmKNVXfPp01I3QMEnEbA9BM66nbyusbgIM/9Ej
         /ZcqyPzE4ZZIUPGPxjGscIVJ/OmTPC2qvpVY5pMQVSi3OuVJzzIWhncgdmrMkDo82/r9
         AaJodW8wmujQRQ3q4sx4LagPjwpcQIGz0eAkg3btHu733arDMPa26MvfNC+94W4aHkAl
         uBZg==
X-Gm-Message-State: AOAM530Vjmo7Ysk7fkBGZpRhR92PYDE7PoVZZrs81SLq0spQRAIQnhRs
        UmPin7j9nbnT/Ac4qszjBxA2BN2aA831
X-Google-Smtp-Source: ABdhPJwM16aZLEuVpLwTy67299TPRq0He33w5X8lg2wGrqQWvmK9C3WinV47QYgAH+Hb3K9GE7XiEQ==
X-Received: by 2002:aca:4fd5:: with SMTP id d204mr2337320oib.86.1602682726745;
        Wed, 14 Oct 2020 06:38:46 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m29sm1182427otj.38.2020.10.14.06.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 06:38:46 -0700 (PDT)
Received: (nullmailer pid 1557348 invoked by uid 1000);
        Wed, 14 Oct 2020 13:38:44 -0000
Date:   Wed, 14 Oct 2020 08:38:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        linux-leds <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Lubomir Rintel <lkundrak@v3.sk>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/6] dt-bindings: mfd: google,cros-ec: explicitly allow
 additional properties
Message-ID: <20201014133844.GA1555058@bogus>
References: <20201013160845.1772-1-thunder.leizhen@huawei.com>
 <20201013160845.1772-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201013160845.1772-3-thunder.leizhen@huawei.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 14, 2020 at 12:08:41AM +0800, Zhen Lei wrote:
> There are so many properties have not been described in this yaml file,
> and a lot of errors will be reported. Especially, some yaml files such as
> google,cros-ec-typec.yaml, extcon-usbc-cros-ec.yaml can not pass the
> self-check, because of the examples. So temporarily allow additional
> properties to keep the comprehensive dt_binding_check result clean.
> 
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> ---
>  Documentation/devicetree/bindings/mfd/google,cros-ec.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

There's proper fixes for these under review.

Rob
