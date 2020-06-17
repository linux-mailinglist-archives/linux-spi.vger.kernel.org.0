Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9F61FD678
	for <lists+linux-spi@lfdr.de>; Wed, 17 Jun 2020 22:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgFQUyQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 17 Jun 2020 16:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgFQUyP (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 17 Jun 2020 16:54:15 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB4EC061755
        for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2020 13:54:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m7so1492314plt.5
        for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2020 13:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=OA+uiTlyL85CZVRoQNcoC7+qlZN6RmKLWW5aiSiJuSc=;
        b=NH/VqbBGwSaY1nzrHm1kEj9rcr4pDtofLKRzAdXGVa0FWB8cs7zmHv2MrzuTEOxuoR
         jqnS8y3QB2ZPfKLqOdPtU2EyEZqqlWe2H16s3046nhZoRfQ+NmZ24dyydktP0azd4CH9
         vpvjer/AXROo2NgkyG2Yv5o67ILRWOfh6VDE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=OA+uiTlyL85CZVRoQNcoC7+qlZN6RmKLWW5aiSiJuSc=;
        b=h/UcU1u4+/WlZiI8qkj3MdqnhgKc3PqzSdz286iGJ/nUqDy2wQaf6kWFAQopYiL/6/
         8V0jWXaBxDHnTVDnmGDftIJw72Utx6PZK/mh4zOYEyL9UPvVoFRjFhRimbfbW5UVypAa
         pj3MmonYuzewBaUloGGSI+xYKnQoJ6DOBRm3ESbQE5CxlRoBmQb7fB+XCvkirSxUcof2
         J1gB3NqWMNVro3P/AHP8DNw6i4SnqitHCm02I0Ih2b0m9YiiV5jwtszzkRhTSzrZVExr
         KZ84woC8OM3N+k/9JVc3ILzKwI2xFzL26sIvHmGvpvZaFKXHlZ+hkE9kr5eM0QicL5Vo
         ihbw==
X-Gm-Message-State: AOAM5335L+dnxejqFJe+/7cdvjfM+9A+nglWZGxnD0gXi+35sv7XVYgz
        qQ1jJoDGFUeerLYE4ncGBYq7Sg==
X-Google-Smtp-Source: ABdhPJwQzv0SQLHzKZqNG5RUwMkhrA80IwPwJOJQUpxUYPiq4LFyAiKMcUt6VkqSVC+bEy+YrFSmmw==
X-Received: by 2002:a17:90a:f414:: with SMTP id ch20mr796741pjb.97.1592427254228;
        Wed, 17 Jun 2020 13:54:14 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id j6sm673200pfi.183.2020.06.17.13.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:54:13 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200616034044.v3.3.Id8bebdbdb4d2ed9468634343a7e6207d6cffff8a@changeid>
References: <20200616104050.84764-1-dianders@chromium.org> <20200616034044.v3.3.Id8bebdbdb4d2ed9468634343a7e6207d6cffff8a@changeid>
Subject: Re: [PATCH v3 3/5] spi: spi-geni-qcom: Check for error IRQs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Alok Chauhan <alokc@codeaurora.org>, skakit@codeaurora.org,
        Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>
Date:   Wed, 17 Jun 2020 13:54:13 -0700
Message-ID: <159242725302.62212.16716926914794028093@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Quoting Douglas Anderson (2020-06-16 03:40:48)
> From reading the #defines it seems like we should shout if we ever see
> one of these error bits.  Let's do so.  This doesn't do anything
> functional except print a yell in the log if the error bits are seen.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
