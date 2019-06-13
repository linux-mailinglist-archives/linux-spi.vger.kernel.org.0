Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47AF143D1F
	for <lists+linux-spi@lfdr.de>; Thu, 13 Jun 2019 17:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730603AbfFMPjm (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Jun 2019 11:39:42 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33874 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731913AbfFMJyY (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 13 Jun 2019 05:54:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id c85so11527287pfc.1
        for <linux-spi@vger.kernel.org>; Thu, 13 Jun 2019 02:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hjw/27BiWyRsokNbznNmO94DEfRuOPMKzlIXgRI+H5k=;
        b=WUhQgDpav09wCsvAut2BWW+R7sS7LtghDHpfI6v0bUGLZjzR+QUQRAULtuQ+dBOAS+
         5B9NTVliKzqPVgFAQafRgRYnR51hBF4bFPqnp+SsVxb/s1dw527gW4ZdAD71YLZdwcQ0
         kP0XOt6g2JH7P49I+eaVhp4nGWzzZa4kZC41fTHL4Dh4FeCF8y1xkbVGRNCVSFpZMYT1
         seXbQTfhtWg/Y2ZFYMhZdfSkXlmqGNBTcy0L6z6YZU0v3YRzsY93irO3uxYz27fLorQY
         xCaAv7PNE+Wc9gb1a0ZIBFgBoTFuvbNfAi4+vMKRTRmWIgoX9FjCYaWw5pHArsOCxWin
         Y5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hjw/27BiWyRsokNbznNmO94DEfRuOPMKzlIXgRI+H5k=;
        b=nM+E+076xRKbLCv4+47FcdVYSTYVA9x/ZaOoAd5zxF43Y2V/qbYzjsFAN9TU4gAggu
         7W+6efIMxcN/8U5saiIkbDC88u0tpVmiuoV0H5m20YsmaGRok7UyYbikG151H6iG+rQe
         01POWbSIXLz+CxcOlYxGJF/1tWYn3nv3oYDXCjFFzcX+UKLRD8tngnwA6gndFZdRDWCd
         gsIbLehA65u8y8xcHff0S9RkEiBE3bHGg67o28oO+kLrA93bjY7m+GXAa1iTbm30y9gV
         dQNREEhZjN6rE+mOAzwT4g2OMAUgU6EJViZwLzBaOpvPbFAnGXJeg/qGu4KS816Dyfjq
         2oFg==
X-Gm-Message-State: APjAAAXlHIQG4zNt2AtZeBNJ8xDNdkr24XrJSKqM1I9+PRBlKgY+qwTV
        VlQ22B4lNdN8cC1t9XYqXRmQaA==
X-Google-Smtp-Source: APXvYqyRW+yesk5LbA1w8QMeFbdIKEhSaWce+1/TtkgKa+kMImAbjDmOqy9rTc27doz8KV05Ir4xXQ==
X-Received: by 2002:a17:90a:3225:: with SMTP id k34mr4393711pjb.31.1560419663353;
        Thu, 13 Jun 2019 02:54:23 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id u97sm3965453pjb.26.2019.06.13.02.54.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 02:54:21 -0700 (PDT)
Date:   Thu, 13 Jun 2019 15:24:19 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     swboyd@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        vincent.guittot@linaro.org, mturquette@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, ulf.hansson@linaro.org,
        dianders@chromium.org, rafael@kernel.org
Subject: Re: [RFC v2 01/11] OPP: Don't overwrite rounded clk rate
Message-ID: <20190613095419.lfjeko7nmxtix2n4@vireshk-i7>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
 <20190320094918.20234-2-rnayak@codeaurora.org>
 <20190611105432.x3nzqiib35t6mvyg@vireshk-i7>
 <c173a57d-a4de-99f7-e8d8-28a7612f4ca3@codeaurora.org>
 <20190612082506.m735bsk7bjijf2yg@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190612082506.m735bsk7bjijf2yg@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 12-06-19, 13:55, Viresh Kumar wrote:
> Okay, I have applied this patch (alone) to the OPP tree with minor
> modifications in commit log and diff.

And I have removed it now :)

I am confused as hell on what we should be doing and what we are doing
right now. And if we should do better.

Let me explain with an example.

- The clock provider supports following frequencies: 500, 600, 700,
  800, 900, 1000 MHz.

- The OPP table contains/supports only a subset: 500, 700, 1000 MHz.

Now, the request to change the frequency starts from cpufreq
governors, like schedutil when they calls:

__cpufreq_driver_target(policy, 599 MHz, CPUFREQ_RELATION_L);

CPUFREQ_RELATION_L means: lowest frequency at or above target. And so
I would expect the frequency to get set to 600MHz (if we look at clock
driver) or 700MHz (if we look at OPP table). I think we should decide
this thing from the OPP table only as that's what the platform guys
want us to use. So, we should end up with 700 MHz.

Then we land into dev_pm_opp_set_rate(), which does this (which is
code copied from earlier version of cpufreq-dt driver):

- clk_round_rate(clk, 599 MHz).

  clk_round_rate() returns the highest frequency lower than target. So
  it must return 500 MHz (I haven't tested this yet, all theoretical).

- _find_freq_ceil(opp_table, 500 MHz).

  This works like CPUFREQ_RELATION_L, so we find lowest frequency >=
  target freq. And so we should get: 500 MHz itself as OPP table has
  it.

- clk_set_rate(clk, 500 MHz).

  This must be doing round-rate again, but I think we will settle with
  500 MHz eventually.


Now the questionnaire:

- Is this whole exercise correct ?
- We shouldn't have landed on 500 MHz, right ?
- Is there anything wrong with the above theory (I am going to test it soon though).
- Why do we need to do the first clock_round_rate() ? Should we remove
  it ?



Now lets move to this patch, which makes it more confusing.

The OPP tables for CPUs and GPUs should already be somewhat like fmax
tables for particular voltage values and that's why both cpufreq and
OPP core try to find a frequency higher than target so we choose the
most optimum one power-efficiency wise.

For cases where the OPP table is only a subset of the clk-providers
table (almost always), if we let the clock provider to find the
nearest frequency (which is lower) we will run the CPU/GPU at a
not-so-optimal frequency. i.e. if 500, 600, 700 MHz all need voltage
to be 1.2 V, we should be running at 700 always, while we may end up
running at 500 MHz.

This kind of behavior (introduced by this patch) is important for
other devices which want to run at the nearest frequency to target
one, but not for CPUs/GPUs. So, we need to tag these IO devices
separately, maybe from DT ? So we select the closest match instead of
most optimal one.

But lets fix the existing issues first and then think about this
patch.

-- 
viresh
