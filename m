Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1C6207A71
	for <lists+linux-spi@lfdr.de>; Wed, 24 Jun 2020 19:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405589AbgFXRjx (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 24 Jun 2020 13:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405427AbgFXRjv (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 24 Jun 2020 13:39:51 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0BAC0613ED
        for <linux-spi@vger.kernel.org>; Wed, 24 Jun 2020 10:39:50 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id bh7so1313056plb.11
        for <linux-spi@vger.kernel.org>; Wed, 24 Jun 2020 10:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=icPG8hObHg8yafPJKwf2o4eaI571GeN/laooKjhqnGA=;
        b=ccU9fEXoNSEIM7OOQ/yadogIOyX0u9hfrmr0o3aOPCOthUpjuoBld3sSt+PdY3i0Qr
         XrYjEd28vcqX+7L5zyThYAz5CZMd1Rx4YAfvSNHxP8Vf+rBZyFqtdiKeuZ67i/ak9icd
         O3ksW4NGLZpdaE9RP9XJC3jE75u/oa2nEAAJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=icPG8hObHg8yafPJKwf2o4eaI571GeN/laooKjhqnGA=;
        b=MhLWryhQuILakmcvuAWUFZkanvpVqudMU0FAeXMjQczmwqkfuz6EEcXCCV8HH//1DU
         1MRbrlDme+jzhxlfyx/9NPz8+CE6xzBRsIFKps/N6xGKizn98+/xx023dMnh27iMrzns
         FolbTZhzUQR7fwvb/jdLX8Z4FZdquTHolCuHdk8NWdZaA+vQV6OVSz4wsLv0F8VBAuD9
         X3m+5T/EzvQ7K53KFcrssdzGUEkRx0rOkvPY5IaKsYtjM+M+VVxI27rlkX6R8EOc/L1q
         bDAEp6dOL1RnPdmEy2BvHXp7FQo3EJLW2gmQwStGU8UV41Zpj4PP2egG8EEqc+1TLjhl
         Thrw==
X-Gm-Message-State: AOAM533DtN0c+lMRrMyGemrWLzymj1tsjtGIHJKbNdjMFFONgBmLSf+c
        buBtVellfp+2utl6FFsNilKtzg==
X-Google-Smtp-Source: ABdhPJxEB785qbfd6S3Vxd6Ma7a0jVEjXIBDvEs8LRmaTNVuKN6yFPJfwMEa04arCunvtaU7Med6og==
X-Received: by 2002:a17:902:b60f:: with SMTP id b15mr29521587pls.248.1593020389993;
        Wed, 24 Jun 2020 10:39:49 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id z5sm501869pfb.1.2020.06.24.10.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jun 2020 10:39:49 -0700 (PDT)
Date:   Wed, 24 Jun 2020 10:39:48 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>, bjorn.andersson@linaro.org,
        agross@kernel.org, robdclark@gmail.com, robdclark@chromium.org,
        stanimir.varbanov@linaro.org, viresh.kumar@linaro.org,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v6 6/6] spi: spi-qcom-qspi: Use OPP API to set clk/perf
 state
Message-ID: <20200624173948.GC39073@google.com>
References: <1592222564-13556-1-git-send-email-rnayak@codeaurora.org>
 <1592222564-13556-7-git-send-email-rnayak@codeaurora.org>
 <20200624170933.GB39073@google.com>
 <20200624171537.GL5472@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200624171537.GL5472@sirena.org.uk>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jun 24, 2020 at 06:15:37PM +0100, Mark Brown wrote:
> On Wed, Jun 24, 2020 at 10:09:33AM -0700, Matthias Kaehlcke wrote:
> > Hi Mark,
> > 
> > do you plan to land this in your tree?
> > 
> > I know you hate contentless pings, but since you acked this patch and
> > usually don't seem to do that when patches go through your tree I want
> > to make sure we aren't in a situation where everybody thinks that the
> > patch will go through someone else's tree.
> 
> Aren't there dependencies on earlier patches in the series?

Not to my knowledge. Patch "[2/6] spi: spi-geni-qcom: Use OPP API to set
clk/perf state" depends on a change in 'include/linux/qcom-geni-se.h' made
by "1/6] tty: serial: qcom_geni_serial: Use OPP API to set clk/perf state",
however that's not true for this patch.

I wonder if it would have been better to split this series into individual
patches/mini-series, to avoid this kind of confusion.

> In general if someone acks something for their tree that means they don't
> expect to apply it themselves.

Yes, that was my understanding and prompted me to clarify this with you.

The patch could go through the QCOM tree, but to my knowledge there is no
reason for it.

Btw, the patch "[V8,7/8] spi: spi-qcom-qspi: Add interconnect support"
(https://patchwork.kernel.org/patch/11620285/) is in a similar situation.
Another patch of the series for the 'spi-geni-qcom' driver has to go
through the QCOM change due to changes in geni, but the QSPI driver
doesn't use geni and could therefore go through your tree.

Ultimately I don't really care too much through which tree the patches
land as long as you and Bjorn agree on it :)
