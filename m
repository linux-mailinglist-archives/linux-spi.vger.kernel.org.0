Return-Path: <linux-spi+bounces-4733-lists+linux-spi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258FC97143D
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 11:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3C72850D6
	for <lists+linux-spi@lfdr.de>; Mon,  9 Sep 2024 09:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEE81B3F21;
	Mon,  9 Sep 2024 09:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbK5qVmw"
X-Original-To: linux-spi@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBD71B3F24
	for <linux-spi@vger.kernel.org>; Mon,  9 Sep 2024 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725875125; cv=none; b=G/4yArsCR4+3PtvwA7qvD2y8hcHLZg5lbMO5MbXlcV4o70/eUIvmG/Sii0mFdlS8lQLKip6Y+cGF7uyrDp7+Pvg88LtVHmfg6xXckyS/A0XHcXEBh4LjQVcYgDnhfknRsZ3Och0Hkfo+veaX6XdoSS4heuM/ycCeyrehv0m1jiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725875125; c=relaxed/simple;
	bh=GnnRCpZVq2X1JDH9jD+/G2ACm1S8JXfbtnAfz+3rWKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0S26Rmf59aRVzkDSJHHo12QcthopI0VPCtYMhtwnPsPy1W6NET8YqH58T0KgoXhBD3MMB1gpp7VBxDNKrSKbV5BKEexrRqfX/rfS3Wi1SxFrT6ClOwUS0ivFfBM01xRRf74Mx9IgJ9YbLUY4rxFEn1rrajsGLMK3/OxOU9flwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bbK5qVmw; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5365928acd0so3311045e87.2
        for <linux-spi@vger.kernel.org>; Mon, 09 Sep 2024 02:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725875122; x=1726479922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AX+qWUEl4qvHchK9WiUGhJ8YcoviFbmZ6OHD06M6LpY=;
        b=bbK5qVmw2DAVHd5NwaJ39CKLhapZsPtazhlwJMnUZ+MwE55b4/+ll0y3EkJIfNT5v+
         BKUKPTpRC6jkU1McZZbZ8T+YXNu0heCgLgb0LJkQiCM6qfuVDKf235tmNYr9r+QQaIGn
         CBiFwMHnMO8duVexhTtk500RTWpNEm7MHmNDzvb3NoxDjIoNn/wp2j3WkD2ZWrzY9DrL
         BaxjqgBAQZWz3Lb0po0gb2exmWF1Ku3tj6LK4wqnmbuYFnV8HhVMOKfxj+mDERQEEUg7
         bmyPZaKr8LS+AC5qlc86Q9s9i9b7j7LyIS/iThCFzeoRpOcEfEG7zWMm7vefTmRBS7em
         JaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725875122; x=1726479922;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AX+qWUEl4qvHchK9WiUGhJ8YcoviFbmZ6OHD06M6LpY=;
        b=UA24Vy0okpSFrqjSCz2JjDxdGagulCMCiHhEaUBy3fcTuyDGO9jgWXKsZoxCRA9iy7
         29nP941LIKNTbDt5UJInO94pweVujEF8R71G28Y8zWhNYi42PB1ZQ/aJbl2qE8t4Motr
         qvX77pelW8v5Ut6aFpsQkz8Dn+heaGu4uN+SrampfxcQshTHAiA74zvScKZfZvWM/eq3
         zgLmtQfWyQEdbcWsu5TSBz1ymN18Am6j7tovCOWB6ieSZ2sL0cvVhpLCYMhF/z92rFIX
         Cib/j06CQYQmXizrMEIiGXyaavvh5b+RWIrVtg4uk62vbTT8HaI+4T6cwCNdF7sX1IYg
         BB+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCo/R5E7XxWWMNDNoOcmtc2TcGVOk5Nu8RV7yR5qe/nq8yy2/6T8POuMIVmEeIYvVhugHmq/hA+Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIf8UunL2pvubLLgeIGZex7LWqnkyEb09ckW1nfdK+cv1CfH7g
	/C3JS6pzQxltbKst4LeqkQPi4c3o9Z5770FTibEibev3ZIiylKNMMHQLBXFI7FT7SklxN1QnmcC
	/
X-Google-Smtp-Source: AGHT+IHdf/Swn2REUiirGgiZlsVzxHynFgW8MF5+sSjhKD0Ffob+MA01ZDe6vv0aCi8IkWfLDJz4TQ==
X-Received: by 2002:a05:6512:3b10:b0:533:4656:d4cd with SMTP id 2adb3069b0e04-536587c641fmr8195958e87.33.1725875121427;
        Mon, 09 Sep 2024 02:45:21 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f86fff0sm710516e87.82.2024.09.09.02.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 02:45:21 -0700 (PDT)
Date: Mon, 9 Sep 2024 12:45:19 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: broonie@kernel.org, akashast@codeaurora.org, dianders@chromium.org, 
	vkoul@kernel.org, linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] spi: geni-qcom: Undo runtime PM changes at driver
 exit time
Message-ID: <pxv36kfon3zdwa2els6d65kgpiyn35ogcylo2z6ay7jrzyb6x2@jblxqzvf6qpu>
References: <20240909073141.951494-1-ruanjinjie@huawei.com>
 <20240909073141.951494-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909073141.951494-2-ruanjinjie@huawei.com>

On Mon, Sep 09, 2024 at 03:31:39PM GMT, Jinjie Ruan wrote:
> It's important to undo pm_runtime_use_autosuspend() with
> pm_runtime_dont_use_autosuspend() at driver exit time unless driver
> initially enabled pm_runtime with devm_pm_runtime_enable()
> (which handles it for you).
> 
> Hence, switch to devm_pm_runtime_enable() to fix it, so the
> pm_runtime_disable() in probe error path and remove function
> can be removed.
> 
> Fixes: cfdab2cd85ec ("spi: spi-geni-qcom: Set an autosuspend delay of 250 ms")
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> v3:
> - Fix it with devm_pm_runtime_enable() as Dmitry suggested.
> - Adjust to be the first patch.
> - Add suggested-by.
> v2:
> - Fix it directly instead of use devm_pm_runtime_enable().
> ---
>  drivers/spi/spi-geni-qcom.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

