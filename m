Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792EA7A9F7F
	for <lists+linux-spi@lfdr.de>; Thu, 21 Sep 2023 22:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjIUUW5 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 21 Sep 2023 16:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjIUUWm (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 21 Sep 2023 16:22:42 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDA1746987
        for <linux-spi@vger.kernel.org>; Thu, 21 Sep 2023 10:14:28 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-501eec0a373so2182169e87.3
        for <linux-spi@vger.kernel.org>; Thu, 21 Sep 2023 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695316466; x=1695921266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TyP2lCq/bSVDqnymObET8LaEFUP8CozqrWimSDgxYug=;
        b=DXQd/b9x3BMkHFZRK3l6zVhiY6vgzyGC7ejRr5SSNYp9CbZ1fiZz19be44D+y5ULlW
         fEP+9AaSCd0xu2FEgWFqaxrDza9BR/i0TDtk317J1NciKmWym8P1qTu9IP/j/WFZvcGu
         Pp6dIqaZ0AQMITOCcsnAlbgbxdM4G0dfGmTSFhC7M0C+zcoeZh3xkh+jkwS4ex5GlaRm
         /6kIV0ghrcCNm+bd0A+6aeYEyM11kbGxKXZNYh/kiySdidZIyJWoJ6mpJYmtn69ruCmh
         y2N+W+tzlMBgQkjoHalO92PlRSf/36e/k/2Hk0PY1911NhtZqs7xoG3SShrOvm/ZfJAZ
         /gzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695316466; x=1695921266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyP2lCq/bSVDqnymObET8LaEFUP8CozqrWimSDgxYug=;
        b=ofagYsx0tPrG8qCkOviRT+SCGTugJv5eR2WuAkvvJQUSpiigsyvBxBL7oXQo1s/rtD
         Py8QNGrSYA7HZqBBtA1cY5oyQNJtGh0o3oItQ2Cp8vhzacmtNPkxX8k5h8DUmVOa3rgX
         F83BYGzStEDjfhhuTAXplofYEmYTFPQUFoLuXM8NEOqF49F8e3p/HUvTr6s/fVkCKHVI
         4xv3JSqoGDRVyMJCc7CLh5KZZhH/QcDy1Q1S/iczQs6u0TPjo3WNLtFespTvSzxlcoE1
         QLZYzU13d03bdFGddGAc2PD7n2K0P5Xh8BG1NYLq0uQc5JM6+KSspym2NI4REDIvq9YZ
         q/OQ==
X-Gm-Message-State: AOJu0Yx6NVkMcBL8PSyjTETzsOqKxizJCQnCJmhJthVZGt5xCPqM+Htj
        WjvacVY6pr7cN6tZhUbF0I8mbbVJkYwyE8QHX18=
X-Google-Smtp-Source: AGHT+IH7MKMHV9VB90sQpv2wzEE59MEaGFNnOBSPTzvhLiKFZK1jcxpcDDQfJlGWhkCqwWfQwxUiEQ==
X-Received: by 2002:a05:6512:2109:b0:503:c45:a6e9 with SMTP id q9-20020a056512210900b005030c45a6e9mr4537033lfr.39.1695297789448;
        Thu, 21 Sep 2023 05:03:09 -0700 (PDT)
Received: from localhost (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id c19-20020a056402121300b0052e9b50dafdsm732376edw.33.2023.09.21.05.03.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 05:03:07 -0700 (PDT)
Date:   Thu, 21 Sep 2023 14:03:05 +0200
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dhruva Gole <d-gole@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2] spi: spi-cadence-quadspi: Fix missing unwind goto
 warnings
Message-ID: <ZQww+c0JIP/EqsXT@suswa>
References: <20230919074658.41666-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919074658.41666-1-d-gole@ti.com>
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Sep 19, 2023 at 01:16:59PM +0530, Dhruva Gole wrote:
> The following smatch warnings [0] were recently introduced:
> 
> drivers/spi/spi-cadence-quadspi.c:1882 cqspi_probe() warn: missing
> unwind goto?
> 
> Fix these warnings by releasing dma channel and adding a goto fail probe.
> 
> [0] https://lore.kernel.org/all/5e21c351-cd08-443e-8509-aecf242a4da9@kadam.mountain/

Really this should be the Closes: link.  I should edit the zero day
bot emails to send the correct link.

That's going to be slightly more complicated than you might assume...

I'm travelling now so I won't do it today.

regards,
dan carpenter

> 
> Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202309140543.03dMbMM5-lkp@intel.com/
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---
> 
> Link to V1:
> https://lore.kernel.org/all/20230915123103.2493640-1-d-gole@ti.com/
> 

