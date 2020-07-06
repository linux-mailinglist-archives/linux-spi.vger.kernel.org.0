Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764C9215B55
	for <lists+linux-spi@lfdr.de>; Mon,  6 Jul 2020 17:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729441AbgGFP6U (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 Jul 2020 11:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgGFP6T (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 Jul 2020 11:58:19 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B97EC061794
        for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2020 08:58:19 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d194so15207422pga.13
        for <linux-spi@vger.kernel.org>; Mon, 06 Jul 2020 08:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9RVtaJ0LNajH8tL25qGstAaY61Hw21/Gz13XlQLJwww=;
        b=PCh8WtzLeJQMoqoq3/Tnrt0CuSDAQ+DIzFonqrKtoRZjJfr/tEk3HFHYPM3L5tm25y
         weOqF5kOYlu+N1df0SXec2EjHElqO5xLSDH+fJUI63HbaqCYOq/vER3IGmw6JvwyglFR
         tJbWSgFgLoQrJhXMDcvjoIO3XCGagDxbLerDs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9RVtaJ0LNajH8tL25qGstAaY61Hw21/Gz13XlQLJwww=;
        b=CbJEnfi5x92WiDYzOyBlMvIxUcgsB5IMK6+UWNgpVcsUc0SZ8Lp8yqXK8WO7nn2Yqc
         7Ncfs3zPd/F4lsOVgw1CYLA0ioBQqYUaaOZQKVtuoE4Al9ZD9EyKqSsKOw6Z9kJUl7aK
         6z19xOHpU8/dzX6ysiBw/sXzMIPa6VfTt1NBtHv3t0txn/anltvkL6/EzkU+hqHvexl/
         ob0lXTu6W22d4q/zddQEYKJ3wH9Ncp/8YD+3++JEWzkh0I13Y6bE9jt+MLX8BdR/F9xg
         GpjkdAhP+YgnuV41pxoCNiY6bStzhopqlgzMWRFdfv4KS/xPkvQyueTiD4gycZstHCVx
         c3pQ==
X-Gm-Message-State: AOAM533DDAnOunKlheGZ/1BlLOvCq7BEyncP3nvXGtNBEuK2r9VuLdXq
        fXi80PFrkG5QoM4ICee7uPmlLw==
X-Google-Smtp-Source: ABdhPJwwxnF0fvOInGc/EtJiOlVFU1DmGn20sGPRjobjVNUcDMlD6m90eL/Rxz6px65Z3jOvRna5Ng==
X-Received: by 2002:aa7:8090:: with SMTP id v16mr5665995pff.199.1594051098637;
        Mon, 06 Jul 2020 08:58:18 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id cl17sm19008565pjb.50.2020.07.06.08.58.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2020 08:58:18 -0700 (PDT)
Date:   Mon, 6 Jul 2020 08:58:16 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, broonie@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: sc7180: Add qspi opps and power-domains
Message-ID: <20200706155816.GF3191083@google.com>
References: <1593769293-6354-1-git-send-email-rnayak@codeaurora.org>
 <1593769293-6354-4-git-send-email-rnayak@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1593769293-6354-4-git-send-email-rnayak@codeaurora.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Jul 03, 2020 at 03:11:33PM +0530, Rajendra Nayak wrote:
> Add the power domain supporting performance state and the corresponding
> OPP tables for the qspi device on sc7180
> 
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>

Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
