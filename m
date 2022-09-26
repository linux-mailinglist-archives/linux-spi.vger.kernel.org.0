Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD7E5EAF4B
	for <lists+linux-spi@lfdr.de>; Mon, 26 Sep 2022 20:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbiIZSLU (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 26 Sep 2022 14:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiIZSK4 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 26 Sep 2022 14:10:56 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A215BC13
        for <linux-spi@vger.kernel.org>; Mon, 26 Sep 2022 10:57:22 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z13so10044752edb.13
        for <linux-spi@vger.kernel.org>; Mon, 26 Sep 2022 10:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=CRllL3Ms27ez6IvzpulcJLbYxFjEBlXHOPdBJd/sz8s=;
        b=fPQKgx4TS11TfHGmZSQfrQZmQCjzIq6WYbnOn91p1FnXfYL2FssItOeiYcRAAJoMHt
         NYJlewB6mtl8i0wgnlv8CImD/HfFd09rV5rqe/en2NtGRQvt2vUhl5k/rldwn9Li/OXx
         GUlA8HWcdDVCM1kzMnUDADaTaNVOuuGMz5VQ8ufucx8oR4ajXEfk3fwN+MNl6Cb58gZQ
         IIiM3rrlc7ujpuXEDlMhj8LXX/8TT6LifeNtrlfrAJd/ItOKueJw0YEJCpTVxAP93dhu
         YskBD0FwG6tE+MOXeQ4XCQ696G2KUiv30Wphd3N8KC5nW+c3PsLfp5wTrq+iH2/R0J2Q
         lFpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=CRllL3Ms27ez6IvzpulcJLbYxFjEBlXHOPdBJd/sz8s=;
        b=1XmKJnPVcoNagtHMJWNAx6qd7ldo3Ks+al+P0R5rJf0qVOsHeUbdEwSfBcf68Cx4or
         q+dq5ILe6mkbT8GD7/roc562r/zt7l+cFaI2l4wODcIy+zPO4ueRTlTKrpih8/ewaO+6
         h5pbFG45RbENVYpN8mjPdRj2jq6RQQhEH2CNyBrDRocCeAsTTQ3IhP2Aa8jGF+i+ed6K
         e2CrcTptgxlwsW6qlIxn9df0V16clPtPvMjR7SThHzZaKB+l7c09RMQ35qfiR5499NUU
         lSAIEW+VhJsmy+lzyx6n6AgBUGwGIqcnSNW4aCZUlo0795g0yRFkpo6dhrCdGBz4q7ht
         QGXg==
X-Gm-Message-State: ACrzQf35K8FSmZzp32ydypKz6Gta9L5BUaDTMnZr+ZAqSVxB4hIsU0Dy
        2yU5Esw8G0SvN1GOiqiOY6Y=
X-Google-Smtp-Source: AMsMyM6X8Z1KaqD7FetPssrNuJa1z/BZJHXsq85uYcL65aHyjy5MsukqxLmvrOiTgOYncGHcGlqkBQ==
X-Received: by 2002:a05:6402:538f:b0:444:c17b:1665 with SMTP id ew15-20020a056402538f00b00444c17b1665mr23841687edb.98.1664215040916;
        Mon, 26 Sep 2022 10:57:20 -0700 (PDT)
Received: from skbuf ([188.27.184.197])
        by smtp.gmail.com with ESMTPSA id x14-20020a056402414e00b0043bea0a48d0sm11838458eda.22.2022.09.26.10.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 10:57:19 -0700 (PDT)
Date:   Mon, 26 Sep 2022 20:57:17 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-spi@vger.kernel.org, han.xu@nxp.com, broonie@kernel.org
Subject: Re: [PATCH -next 1/3] spi: spi-fsl-dspi: Use
 devm_platform_get_and_ioremap_resource()
Message-ID: <20220926175717.hrotmqwqe4vxfgif@skbuf>
References: <20220924131854.964923-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924131854.964923-1-yangyingliang@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Sat, Sep 24, 2022 at 09:18:52PM +0800, Yang Yingliang wrote:
> Use the devm_platform_get_and_ioremap_resource() helper instead of calling
> platform_get_resource() and devm_ioremap_resource() separately.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---

For the series:

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
