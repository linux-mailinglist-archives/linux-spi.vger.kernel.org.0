Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04EF84795A
	for <lists+linux-spi@lfdr.de>; Mon, 17 Jun 2019 06:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbfFQE05 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 17 Jun 2019 00:26:57 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:34248 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbfFQE05 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Jun 2019 00:26:57 -0400
Received: by mail-pg1-f170.google.com with SMTP id p10so5044802pgn.1
        for <linux-spi@vger.kernel.org>; Sun, 16 Jun 2019 21:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PmqFguwW3dYc7xJhH5/ZTk/3G85fwsIEI5IZBeTVbMI=;
        b=T1bv07G606y22acLgdMZkhaLJx08RUHyZBX7NdaHMzsC4fMzVPcJ02aU7u5IykZhqg
         SlAfQR0uFoGC+bPxUEGOXI6tFFYfoZLFmk1py+M7f9MftwDzqJCzY/6BvQ/k10SbjYt1
         Sg1ky4ojNLm9kyNOa+3B56ibkdrvgeDgx55vLLfg6TT86hDy2fCvMyIViyZ5nFPI/4lW
         8RDCU91bKDgJHKygUFl6M+7lyW6y3JosmhS2sCekPqqmfPvshQ/fh9FJsbXHh/LF1BcH
         bCzZn5g4twxBZ7Rsn0H8SegEmRp47yDF57icq13SQvZfGTFfOwW9xlLbgilfbDOsQkQI
         LETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PmqFguwW3dYc7xJhH5/ZTk/3G85fwsIEI5IZBeTVbMI=;
        b=t8RrzNmnVf/+Vwsf1/2CR8T5mF0EltlCH3AW4lT1rHkU37924lID1vXXVuVptm0J9h
         XmoUk0adrIKEUyyekqQR2V+QlPwwyYIeI5WOZt6LQyzgYrCm6GUV7c50pex8n4QOrTYE
         DoW2dzyL894mJXllcwG8b8tHdlk6fzBMAxXG9OOxJS842EJhBIjJR6gWs40WRcVyXtaU
         hCkBZxMJ8QpDKl3LtDhZUJmW7ORcbymVDkbmYjCtC2mCPvXXOkHPqcC7H84rF/EQ6v8G
         Ws15TM6t3EGMRWYjrkyAllNOWpiQNS6/QMPw6yb8NsbHtLqo2tV1NMdU6/4vTY3mcWe5
         9v3w==
X-Gm-Message-State: APjAAAVcK/ErqwBjxZ383o7LxiyL9C37Co5eR0Y7Iev2GDeCCBCCYxOZ
        nIV8rECwH0ANHKWNLwZEqj4XHw==
X-Google-Smtp-Source: APXvYqzqf2rvVzZQ9jtplmCuuCEzv3tRRPzxsJ+P8Z5XBfMDeAYsYxpXV5gZplXN6I0Z9Bp2k24iCA==
X-Received: by 2002:a63:246:: with SMTP id 67mr48365918pgc.145.1560745616533;
        Sun, 16 Jun 2019 21:26:56 -0700 (PDT)
Received: from localhost ([122.172.66.84])
        by smtp.gmail.com with ESMTPSA id s64sm10266562pfb.160.2019.06.16.21.26.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Jun 2019 21:26:55 -0700 (PDT)
Date:   Mon, 17 Jun 2019 09:56:54 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-scsi@vger.kernel.org, swboyd@chromium.org,
        ulf.hansson@linaro.org, dianders@chromium.org, rafael@kernel.org
Subject: Re: [RFC v2 00/11] DVFS in the OPP core
Message-ID: <20190617042654.xdqx5naxo3lq7kv6@vireshk-i7>
References: <20190320094918.20234-1-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320094918.20234-1-rnayak@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On 20-03-19, 15:19, Rajendra Nayak wrote:
> This is a v2 of the RFC posted earlier by Stephen Boyd [1]
> 
> As part of v2 I still follow the same approach of dev_pm_opp_set_rate()
> API using clk framework to round the frequency passed and making it
> accept 0 as a valid frequency indicating the frequency isn't required
> anymore. It just has a few more drivers converted to use this approach
> like dsi/dpu and ufs.
> ufs demonstrates the case of having to handle multiple power domains, one
> of which is scalable.
> 
> The patches are based on 5.1-rc1 and depend on some ufs fixes I posted
> earlier [2] and a DT patch to include the rpmpd header [3]
> 
> [1] https://lkml.org/lkml/2019/1/28/2086
> [2] https://lkml.org/lkml/2019/3/8/70
> [3] https://lkml.org/lkml/2019/3/20/120
> 
> Rajendra Nayak (10):
>   OPP: Make dev_pm_opp_set_rate() with freq=0 as valid
> 
> Stephen Boyd (1):
>   OPP: Don't overwrite rounded clk rate

I have applied modified version of these two patches to the OPP tree now.
Thanks.

-- 
viresh
