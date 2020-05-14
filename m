Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE221D26B2
	for <lists+linux-spi@lfdr.de>; Thu, 14 May 2020 07:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725806AbgENFic (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 14 May 2020 01:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725788AbgENFib (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 14 May 2020 01:38:31 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3562C061A0E
        for <linux-spi@vger.kernel.org>; Wed, 13 May 2020 22:38:31 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id s69so3786649pjb.4
        for <linux-spi@vger.kernel.org>; Wed, 13 May 2020 22:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UWDBJl7OFJuTjUSFJdL9o85ywxwdq0PO2qX4ub+w6Dk=;
        b=bU70OCN5YITDQt7fifRG4Vz6S5uZQ7Y5tRUT81xjWY8+CK7S83RzFuNqoDNprjDZ+x
         K3VhmrzFcc9/KlzCJe0m8r9N+yYOSZexAYOj2KbSm/CymOdSzFWj7FbEmGcJapfUPuQG
         p9bk/XTo/W0sQnXezJs4PzaAn3m6qaYWP9jDrX3G/2aG4UOnUfghh8ZbCh6wCVGkP7cv
         1CDFzC2rRKV286E1SKyBn+N45o/O2/kG8AdFbn3G1oJ8fJaluoEtgwlDs7uSzK4JTl0/
         ADAG1vAAB54XeaYCebhQpsALnxaiW3RxVWub049VKJnfZ76Ml876S55xrSHI/7zwDnJ6
         VeKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UWDBJl7OFJuTjUSFJdL9o85ywxwdq0PO2qX4ub+w6Dk=;
        b=ImOpbAqDDXXQFzYDbAcozYYaIhpV+KT3ZKeeGGoqij1uaCBM1ODEo69Haq1dE1EEs0
         r8c2V0tbul1ED/9L8UGoM6QUyNc14aR+tKX2APmEDlMsBsdXeghRpDRAR/U+wNULYAYw
         EDlbpLWEBk6QmRNp4s7ahGL06hll9JnqF6ngKHCJQTw7LL+SvolQ8dULhd7diI6a5shY
         FHZErjOeDq054SQKSWLr9aDiHvc+y493gK00QAE+1w3O85d890dIVXl0RX8bnIURuq23
         fkYQCXUGLxt+DSZqlf0xpJYZNkorpbQ/38x5GIhaTMidY90fBYSnN05XspyfFT59U2qj
         yOdQ==
X-Gm-Message-State: AGi0PubiNePavgYusXP6WCuHNQmZ/odh/bkgLtxxT5WCACnkMi5+QHFy
        QzOIpFnnXmD/KDH8su+ytFpRKg==
X-Google-Smtp-Source: APiQypIyotmo+7Eku6oIgFkqRSJgL2Rbue4SnzSTK71QCh720tyNYACfrRF3ghvHvY4ZxzbO9r6VsQ==
X-Received: by 2002:a17:90a:8c8e:: with SMTP id b14mr31748893pjo.222.1589434710874;
        Wed, 13 May 2020 22:38:30 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k24sm1167739pfk.134.2020.05.13.22.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 22:38:30 -0700 (PDT)
Date:   Wed, 13 May 2020 22:38:27 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, Mark Brown <broonie@kernel.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v5 2/6] spi: spi-geni-qcom: Use OPP API to set clk/perf
 state
Message-ID: <20200514053827.GK1302550@yoga>
References: <1589368382-19607-1-git-send-email-rnayak@codeaurora.org>
 <1589368382-19607-3-git-send-email-rnayak@codeaurora.org>
 <20200513190752.GS2165@builder.lan>
 <97288c37-66cf-305d-1e62-a0d12b7cba17@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97288c37-66cf-305d-1e62-a0d12b7cba17@codeaurora.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed 13 May 22:03 PDT 2020, Rajendra Nayak wrote:

> 
> []..
> 
> > >   	spi->bus_num = -1;
> > >   	spi->dev.of_node = dev->of_node;
> > > @@ -596,6 +607,9 @@ static int spi_geni_probe(struct platform_device *pdev)
> > >   spi_geni_probe_runtime_disable:
> > >   	pm_runtime_disable(dev);
> > >   	spi_master_put(spi);
> > > +	if (mas->se.has_opp_table)
> > 
> > Why do you need has_opp_table?
> > 
> > Afaict if dev_pm_opp_of_add_table() returns -ENODEV there's no attached
> > opp-table and dev_pm_opp_of_remove_table() is a nop.
> 
> Apparently its not. Calling dev_pm_opp_of_remove_table() when dev_pm_opp_of_add_table()
> failed causes use-count mismatch.
> You can see https://lkml.org/lkml/2020/4/15/18 for more details.
> 

Must have missed that when I glanced at the code, thanks for clarifying.

Regards,
Bjorn

> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
