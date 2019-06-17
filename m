Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3556C47917
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2019 06:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfFQEWj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jun 2019 00:22:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38260 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfFQEWj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jun 2019 00:22:39 -0400
Received: by mail-pf1-f194.google.com with SMTP id a186so4921977pfa.5
        for <linux-spi@vger.kernel.org>; Sun, 16 Jun 2019 21:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fF6C6yU+ctNlGc2XdhZFZfZxRPV+pLz7dQXBNdsmYaM=;
        b=PYYs/y+1YUsOQ0sFRqqd6xXWi4ZM2jSQo31Oth3e1idd3rfW2G4cEqPfTxb906ZHhS
         J20pfjoh+JPr7Ik4Gntk4Q/Pvj8u46EIUPLIJ6ioGwBUrShNhVxeyDWglmH9Ok9TzYhF
         wSZTjnUSQ+qfJxhiBuKgGfh+2fCmWigoLv68DKRuRn6DGjQevSTZ30B10Cx8jD4rNGCh
         eYqw9FCi14QTDsvH7z9+e5wfdAp1yRo61z0kEDVzIrIrgn4kzs674wKYT/MJtQy7+C0H
         IvC1qJHq2Zhw/cgnuPlQpl2i/1E5EmllbfvhrBNp6UdC//DXdizXv6Gxhec6lDyctSGO
         qCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fF6C6yU+ctNlGc2XdhZFZfZxRPV+pLz7dQXBNdsmYaM=;
        b=OhPs5cRIJtA249Kasi4HNwQYKkFQ1C0OwTq37opTXKbKOkcKoCo5QMPncHHRrkkMl4
         +UGbqvnC3qDr29FKBtIaHX5E+iapUMX9ln8dLeq1pOcCv1SdLhNl8wpl4jjlhmDiY555
         6Mu3MJMccG5SH6PbKJafauQ1ewhm7PSfDl1Xj8X6UYTNor0mEhrmq1+IJWnDeF+3WiWP
         OJaleXtfCJ9CaftXUH/4A5O9WgvXjKaVyBMlB+gYhkZZrokLHSZmnHP/6Ggu4b/sIQdt
         847xB/ss1/kK9cp11t9RxRKEQTZilG2ljnubxZd0XWlowuzePBJ0osqSvvdgGqCjaZJP
         wAJg==
X-Gm-Message-State: APjAAAX7+0w/NjmGKvySIxdXaz9h/ytCuEuL2491p+9bYFlZpZARQjIb
        zv1M3+yznCtOs3dtRvKSCeJ6YA==
X-Google-Smtp-Source: APXvYqwGCOwwX/fHLmkix7aoXMTAB8HwyZ9nxohqcmG4iD/6uJ9F4lZt0jQoC6EC0dO6ZKmwaf0C7Q==
X-Received: by 2002:a17:90a:24e4:: with SMTP id i91mr25143081pje.9.1560745043955;
        Sun, 16 Jun 2019 21:17:23 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id w187sm11086622pfb.4.2019.06.16.21.17.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 21:17:23 -0700 (PDT)
Date:   Mon, 17 Jun 2019 09:47:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     swboyd@chromium.org, vincent.guittot@linaro.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-scsi@vger.kernel.org,
        ulf.hansson@linaro.org, dianders@chromium.org, rafael@kernel.org
Subject: Re: [RFC v2 01/11] OPP: Don't overwrite rounded clk rate
Message-ID: <20190617041721.5xdr3kl4xxe6gy4m@vireshk-i7>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
 <20190320094918.20234-2-rnayak@codeaurora.org>
 <20190611105432.x3nzqiib35t6mvyg@vireshk-i7>
 <c173a57d-a4de-99f7-e8d8-28a7612f4ca3@codeaurora.org>
 <20190612082506.m735bsk7bjijf2yg@vireshk-i7>
 <20190613095419.lfjeko7nmxtix2n4@vireshk-i7>
 <20190614052732.4w6vvwwich2h4cgu@vireshk-i7>
 <20190617035058.veo7uwqjrpa6kykt@vireshk-i7>
 <a912c8b2-080d-7ab7-670b-b687ec3a2c92@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a912c8b2-080d-7ab7-670b-b687ec3a2c92@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 17-06-19, 09:37, Rajendra Nayak wrote:
> 
> 
> On 6/17/2019 9:20 AM, Viresh Kumar wrote:
> > On 14-06-19, 10:57, Viresh Kumar wrote:
> > > Hmm, so this patch won't break anything and I am inclined to apply it again :)
> > > 
> > > Does anyone see any other issues with it, which I might be missing ?
> > 
> > I have updated the commit log a bit more to clarify on things, please let me
> > know if it looks okay.
> > 
> >      opp: Don't overwrite rounded clk rate
> >      The OPP table normally contains 'fmax' values corresponding to the
> >      voltage or performance levels of each OPP, but we don't necessarily want
> >      all the devices to run at fmax all the time. Running at fmax makes sense
> >      for devices like CPU/GPU, which have a finite amount of work to do and
> >      since a specific amount of energy is consumed at an OPP, its better to
> >      run at the highest possible frequency for that voltage value.
> >      On the other hand, we have IO devices which need to run at specific
> >      frequencies only for their proper functioning, instead of maximum
> >      possible frequency.
> >      The OPP core currently roundup to the next possible OPP for a frequency
> >      and select the fmax value. To support the IO devices by the OPP core,
> >      lets do the roundup to fetch the voltage or performance state values,
> >      but not use the OPP frequency value. Rather use the value returned by
> >      clk_round_rate().
> >      The current user, cpufreq, of dev_pm_opp_set_rate() already does the
> >      rounding to the next OPP before calling this routine and it won't
> >      have any side affects because of this change.
> 
> Looks good to me. Should this also be documented someplace that dev_pm_opp_set_rate()
> would not be able to distinguish between its users trying to scale CPU/GPU's vs IO
> devices, so its the callers responsibility to round it accordingly before calling the
> API?

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 0fbc77f05048..bae94bfa1e96 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -751,8 +751,11 @@ static int _set_required_opps(struct device *dev,
  * @dev:        device for which we do this operation
  * @target_freq: frequency to achieve
  *
- * This configures the power-supplies and clock source to the levels specified
- * by the OPP corresponding to the target_freq.
+ * This configures the power-supplies to the levels specified by the OPP
+ * corresponding to the target_freq, and programs the clock to a value <=
+ * target_freq, as rounded by clk_round_rate(). Device wanting to run at fmax
+ * provided by the opp, should have already rounded to the target OPP's
+ * frequency.
  */

-- 
viresh
