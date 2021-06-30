Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553A53B8103
	for <lists+linux-spi@lfdr.de>; Wed, 30 Jun 2021 12:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbhF3K7x (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 30 Jun 2021 06:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbhF3K7r (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 30 Jun 2021 06:59:47 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776E6C061767
        for <linux-spi@vger.kernel.org>; Wed, 30 Jun 2021 03:57:16 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u11so3039516wrw.11
        for <linux-spi@vger.kernel.org>; Wed, 30 Jun 2021 03:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DmYIvYkRX4IsUDGy0OBH/JkPnt12KYyi21aGW72CZ7A=;
        b=a04xkbmpsgErnHdAiuLzV3LmUxzEnj6J7OFvUta9tOj3pItR0QD019BYty0qw9Drq2
         KAVo64B7vvenhDkTuN2rh8Uq4Eq5CYAq0/BEY16zf2Ne3ocNS7Ci5Zg5triMs4Bx5d1l
         bWVr4SUr1KH6q78WJnKY9ZE0dmLhwBcxnYck12xsH93G4uupfbxZ6E3tNkHH+kB2Fmnc
         WVtDZc2WIn/rYzg+Lr22qtdarrR2E3oQeWDnaSNFhOMj48zDb7OZc11guCyK3+pKWF+H
         Dr4kLs8Y0MyPZem/hodGmxABYKw8lhGCKBDwTQJRzcX8D0K+jqAADmBfFtlzCeTAvEvP
         d6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DmYIvYkRX4IsUDGy0OBH/JkPnt12KYyi21aGW72CZ7A=;
        b=MVeKKarcjZBK+Nk1qMuoe1u9yZ9ZLJdwYLO92z8ppNLjYbTDHVcnPhsZQEUAUWlOSw
         fPYyG+R3nnBwERI49CUfJ7hoDHdV03ipSEs+QvF30nT78sc2489BLb78WIiM/oqIHbLb
         BMLId/5+E+DTbk1S+JC5LviHOSp175h81diRVlyLdbZDa8/udleeIXxfD1aaEyyR5RPY
         JrrIwpOQlxgwneewZ20jRwObItJQzGpwp8q0cVCrdpJs305+eNp7cHlDTS1LfYqX5EKt
         Z/Lj5Y/bUQS6wi5PVmul3aCQOiSI/h7Xc3Yxjz4doMw7lBOo+H4X73MGXN0Zzu+cfQPE
         V9kA==
X-Gm-Message-State: AOAM531fnq8XcpZVsJBruN4WFG+tCzDQDvzved0YextdHbc81xsUNpGI
        QUk2uhTwdwQLEoMzBRFEPejIzw==
X-Google-Smtp-Source: ABdhPJz3JeDagWbYMUoFJT/9R94VInUH6Gicf0QhP+KXAgXOEqIJFHfg3tish5VeJwfEtFNxv+L7NA==
X-Received: by 2002:adf:ff8e:: with SMTP id j14mr38565132wrr.374.1625050634869;
        Wed, 30 Jun 2021 03:57:14 -0700 (PDT)
Received: from dell ([95.144.13.171])
        by smtp.gmail.com with ESMTPSA id k16sm4653787wru.79.2021.06.30.03.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 03:57:14 -0700 (PDT)
Date:   Wed, 30 Jun 2021 11:57:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Martin =?iso-8859-1?Q?Hundeb=F8ll?= <martin@geanix.com>
Cc:     Wu Hao <hao.wu@intel.com>, Tom Rix <trix@redhat.com>,
        Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Brown <broonie@kernel.org>,
        Martin =?iso-8859-1?Q?Hundeb=F8ll?= <mhu@silicom.dk>,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 4/5] mfd: intel-m10-bmc: add n5010 variant
Message-ID: <YNxOCJNgG5x6zUU+@dell>
References: <20210625074213.654274-1-martin@geanix.com>
 <20210625074213.654274-5-martin@geanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625074213.654274-5-martin@geanix.com>
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, 25 Jun 2021, Martin Hundebøll wrote:

> From: Martin Hundebøll <mhu@silicom.dk>
> 
>  The m10-bmc is used on the Silicom N5010 PAC too, so add it to list of
>  m10bmc types.
> 
> Signed-off-by: Martin Hundebøll <mhu@silicom.dk>
> ---
> 
> Changes since v1:
>  * Patch split out to separate mfd changes
> 
>  drivers/mfd/intel-m10-bmc.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
