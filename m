Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B7828E778
	for <lists+linux-spi@lfdr.de>; Wed, 14 Oct 2020 21:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgJNTkj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 14 Oct 2020 15:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgJNTkj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 14 Oct 2020 15:40:39 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C6AC061755;
        Wed, 14 Oct 2020 12:40:39 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l16so697120eds.3;
        Wed, 14 Oct 2020 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lRMFdmQbJ5RahqqzJGdCdnXN6VjpqgrM3/AzM/NSqzs=;
        b=jIqFCyoO2QgQafSwkepnJAuwDFR6kAlaIBpaKFCSVsIbm3U4IRiuFqrWQK/UuJuETb
         XW2xwse1CbW9hDpK+y5urtEIaZSCf7qMQrl9yeCUxzRp4wJ+eEXlyB5V1keoqkR9VICq
         TG9/oUhge2if8N+DcKMuPw8NQ8ahJiNGsgTwszuj+RxPOh1sYgLssl8BqzU4osOn9Fri
         D5G+QvbdTQfx9C/ueCNid5ERfp5VRa6FtjTUt6Q6D2GZf32NtMXbH4UPx+JwR5bM660S
         /DxCztcH4G3ITPSHS/9slHk1kjkfhBCE4XYEEo2GTS1O4pRihlFmFjrApnCle24ATl+A
         V6mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lRMFdmQbJ5RahqqzJGdCdnXN6VjpqgrM3/AzM/NSqzs=;
        b=Yda9yJAnrD+2VdzwI3IM2kuVYB5cAsafkhuU0jC/kjXnfADVEgNAZlUzshkKq4msc6
         Sd9UXjH94LBnSFE0/3UuHWo9aOcqbIJRR+xLWHIEQqCnBDPttNXE1fbVap/4SnUQSgns
         2tcwN7DDQgGwGJQrP0is5GwCKojL31r2QOYoV8ZNivlH/aY7ZVSqHsvjvtT9aggA/gfO
         2cFAo0eeL0Brjn6PkRfOliN5kavP1yQVNgom50W2Pwvv+EDCJ+RkAmfbRAYngeVma8/8
         mmwZECcpcjlpErQOKuYGu5AKkXQo2NNlM4nz8bSOs1mK1yzrxWAvYa+lkKwObBVc1nw+
         oP5Q==
X-Gm-Message-State: AOAM533o6Z3uA0k3TxPlpT1eJm0leW7T438tqZqiJOT+okyKilPkprMy
        gYLQhjXKxAv+3C/TJEQccEA=
X-Google-Smtp-Source: ABdhPJwTlkidij8uzIBt8afLdP/uVjlMjEX+Qn4s95C4fiJXGrEN7a7XveWZy1IMuR1OgdD8M0N45A==
X-Received: by 2002:a50:ee19:: with SMTP id g25mr622258eds.160.1602704437708;
        Wed, 14 Oct 2020 12:40:37 -0700 (PDT)
Received: from skbuf ([188.26.174.215])
        by smtp.gmail.com with ESMTPSA id x2sm258225edr.65.2020.10.14.12.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 12:40:37 -0700 (PDT)
Date:   Wed, 14 Oct 2020 22:40:35 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: Use after free in bcm2835_spi_remove()
Message-ID: <20201014194035.ukduovokggu37uba@skbuf>
References: <bd6eaa71-46cc-0aca-65ff-ae716864cbe3@gmail.com>
 <20201014140912.GB24850@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014140912.GB24850@wunner.de>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Oct 14, 2020 at 04:09:12PM +0200, Lukas Wunner wrote:
> Apparently the problem is that spi_unregister_controller() drops the
> last ref on the controller, causing it to be freed, and afterwards we
> access the controller's private data, which is part of the same
> allocation as struct spi_controller:
>
> bcm2835_spi_remove()
>   spi_unregister_controller()
>     device_unregister()
>       put_device()
>         spi_controller_release()  #  spi_master_class.dev_release()
> 	  kfree(ctlr)
>   bcm2835_dma_release(ctlr, bs)
>   ...

Also see these threads:
https://lore.kernel.org/linux-spi/20200922112241.GO4792@sirena.org.uk/T/#t
https://lore.kernel.org/linux-spi/270b94fd1e546d0c17a735c1f55500e58522da04.camel@suse.de/T/#u
And here's how _not_ to fix it:
https://lore.kernel.org/linux-spi/160088764365.36195.16185348610086043664.b4-ty@kernel.org/T/#t
At least without some care to not break other things:
https://lore.kernel.org/linux-spi/20200928080432.GC11648@pengutronix.de/T/#t
