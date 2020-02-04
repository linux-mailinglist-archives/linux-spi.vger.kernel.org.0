Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F441521B3
	for <lists+linux-spi@lfdr.de>; Tue,  4 Feb 2020 22:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbgBDVIQ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 4 Feb 2020 16:08:16 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:43929 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727445AbgBDVIQ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 4 Feb 2020 16:08:16 -0500
Received: by mail-ua1-f65.google.com with SMTP id o42so7557uad.10
        for <linux-spi@vger.kernel.org>; Tue, 04 Feb 2020 13:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSnbwBgsFio2ehfBChAWyJkxbhcuFHyXVUzB6wC6EcE=;
        b=FjYS2MR55uToDI5C+GzDlpxU8rd/BFpp55zY9ZUHZkqHH9XTRMqccWRxImQ42ROmuA
         /DEwp9VP5G5lN6LVdd05687vXMcaxB2Pt8lvrpLz6l7VHcX1haY9aYROuZgCs/b9sGuG
         CweceSZSCraRJ1FanI0mhXLFKn3I+UBA5uK98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSnbwBgsFio2ehfBChAWyJkxbhcuFHyXVUzB6wC6EcE=;
        b=ENI6pMqzsmuxlW2BwGzHbPdMyX95gOTT85c83TUDL9B4AaKS8X5hK8YBCJ0jLMV+dd
         8mckqhnytZoCNuMQ5lENLgJ8PztaeNFFWsp2eLlJ6Cz/ym/iuYyNpu05FCldXZQkYNoh
         ekkwch266R3a4USWQCqHYuW/PpEZmWbms+O66DEKUyby7+urNpYnQVmlj/QzR265qzk2
         jiHGqBO0TgB7NDLnzYvxWGrfXzJrpI1ZgW97/PfcUZsb56cUXqqp25RBXmRalgqORnMQ
         WbyjY32yMMJrEXiB5mwk94+iM65RrD9xVXp7Q23P1P0eaA5eJ7CDewpHA+Nph/E268tK
         H9qA==
X-Gm-Message-State: APjAAAUW9f7njx2kcVaJj6M6gdbZUajgzqjvBELoe7PS1yUe5K3hIqEk
        FawnjSDSdYPgTd/I5Yy3mIs+zeIHEOg=
X-Google-Smtp-Source: APXvYqyx5gh2vJpX+Vq3sEKE8jVD1P/dR4hrb/gtKog67DLYBseWDs57hyLV1w4EbU7Idh0fcOQmMA==
X-Received: by 2002:ab0:74ce:: with SMTP id f14mr18226109uaq.118.1580850494906;
        Tue, 04 Feb 2020 13:08:14 -0800 (PST)
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com. [209.85.221.175])
        by smtp.gmail.com with ESMTPSA id l193sm7673300vki.42.2020.02.04.13.08.14
        for <linux-spi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 13:08:14 -0800 (PST)
Received: by mail-vk1-f175.google.com with SMTP id w67so5619989vkf.1
        for <linux-spi@vger.kernel.org>; Tue, 04 Feb 2020 13:08:14 -0800 (PST)
X-Received: by 2002:a1f:a9d0:: with SMTP id s199mr18378566vke.40.1580850493870;
 Tue, 04 Feb 2020 13:08:13 -0800 (PST)
MIME-Version: 1.0
References: <20200204191206.97036-1-swboyd@chromium.org> <20200204191206.97036-4-swboyd@chromium.org>
In-Reply-To: <20200204191206.97036-4-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 4 Feb 2020 13:08:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XLP4Rz9gW4hHDJRf54qFqnYJeXH259_B2Fd5ObTPZUeA@mail.gmail.com>
Message-ID: <CAD=FV=XLP4Rz9gW4hHDJRf54qFqnYJeXH259_B2Fd5ObTPZUeA@mail.gmail.com>
Subject: Re: [PATCH 3/3] spi: spi-geni-qcom: Drop of.h include
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Dilip Kota <dkota@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi,

On Tue, Feb 4, 2020 at 11:12 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This driver doesn't call any DT functions like of_get_property(). Remove
> the of.h include as it isn't used.
>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Cc: Dilip Kota <dkota@codeaurora.org>
> Cc: Alok Chauhan <alokc@codeaurora.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/spi/spi-geni-qcom.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
