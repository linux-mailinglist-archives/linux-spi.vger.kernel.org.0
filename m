Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0A211A5D90
	for <lists+linux-spi@lfdr.de>; Sun, 12 Apr 2020 10:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgDLIsj (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Sun, 12 Apr 2020 04:48:39 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45520 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgDLIsj (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Sun, 12 Apr 2020 04:48:39 -0400
Received: by mail-ot1-f65.google.com with SMTP id 60so6169470otl.12;
        Sun, 12 Apr 2020 01:48:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ryrnnmiWMOzX1gq6Vxt4jaTEpcF4x4xQMMv3P1wro3w=;
        b=ap1+nQp4JovGSL47Qfgt0af2I3wW8FwjJosR61IAiZ24vFpJyPzEdcNgW4eUnw7SCm
         nLlGknlNicfa7luVtRZtCrxBRamWdhpcwKUB0O1M5A1WwO2tVV7KFcnTv45yC3CGwg2g
         2tZwyShL/IU+zlN1iM46HZXyM6D05Xneu9gza0xC6Km2VMGKMjqYzM4HfSakyksRYE0G
         aaQNO3kr7l+WzILi2vhuiHidcx5bdIf2d5NA1SYCSkYU4RMspAwh1oYwj3gp9PTydgGO
         JdtgJUipos5DGm8W61HINmXr8GmlNQlaIwLp97mPGhCljA8f4inwKjs/hoUdbt+2KSvf
         NVXA==
X-Gm-Message-State: AGi0PuZRTtiMuQKVXa1etbeYxgefFMxE31qvK5PGbqaLsv7/OCiXUsDt
        zSb03SYWEj99Pnqq6DFQALJhQUi9i184Co3+SEa5iQ==
X-Google-Smtp-Source: APiQypKUSpUCFnG9oCj6HKDhZzk/Ok0xScPFxCdPYcw8sr+YVgG8G9chaRdg2kv6rM3C9zCB+TMr5Bh/Z160sTLm4gA=
X-Received: by 2002:a4a:95a9:: with SMTP id o38mr10287105ooi.76.1586681319036;
 Sun, 12 Apr 2020 01:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200410122315.17523-1-colin.king@canonical.com>
In-Reply-To: <20200410122315.17523-1-colin.king@canonical.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 12 Apr 2020 10:48:27 +0200
Message-ID: <CAMuHMdVCc34r0jHrn8GiJQCzvRSmUiZgN56D0c_KgSWN0e1W1g@mail.gmail.com>
Subject: Re: [PATCH] spi: remove redundant assignment to variable ms
To:     Colin King <colin.king@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Fri, Apr 10, 2020 at 2:23 PM Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable ms is being initialized with a value that is never read
> and it is being updated later with a new value.  The initialization is
> redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
