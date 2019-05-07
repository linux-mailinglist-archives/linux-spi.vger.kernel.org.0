Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2130E157ED
	for <lists+linux-spi@lfdr.de>; Tue,  7 May 2019 05:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfEGDON (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Mon, 6 May 2019 23:14:13 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33405 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfEGDOK (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 6 May 2019 23:14:10 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so12925976ljc.0
        for <linux-spi@vger.kernel.org>; Mon, 06 May 2019 20:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NAywE/O6BBw64w+qckpowQka/mRy1kuf8xIOtgSlqWg=;
        b=US/fJoAPz7lzHtSZnbgRW4K5atTbEpEBP5zyP2oKurgVKd8txdmImfmaIgshMnEMAb
         xSnmMOZqhcKy1MX50lnymuCMS1McGvzRVrmFv4HQAsgfGfHLaJWK7/2yYGweA3hNu0PN
         AMs1YUN4vcefoei8JVl+AEwOV8XaK9FHWo/vU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NAywE/O6BBw64w+qckpowQka/mRy1kuf8xIOtgSlqWg=;
        b=Y5Cz+whsrSkEZl+AZtKQcbVQiJUBE48ILYA342nXLDSMoUX4SFcFbuld2i3HPU8RZq
         uzUum/42q6M8E8iq8FoWWVMnDetqRs3ztJLwY+H/ALZOlDNMZH1vIqBFujlIA83k09XT
         Q5ByHvZzEaW2vpOGgVjsIK8bUk7OV7fZlWpNdHL/Pih3tHrN63kly1OSlH8I5La+qn2C
         6v9LQG9udPBK5YiumezHQmAQ7F3e1eZNX46ZwgI1of9FewFVMOhgm+SYRDIfTznhOY05
         XoDsmcLBzaWsKFq7UNKVsSo6Z7ukvp3G6pr8VEOWMxd6Nlsisy+Ul1FASD739vKyLgJw
         gIGw==
X-Gm-Message-State: APjAAAW5BzsVNx9E0WomZsabqiyXX7El4md9ifE1lghRnz7HbbwI5jHI
        EcB+vPV3ae7eqDjphAo6W87YH3J04Uc=
X-Google-Smtp-Source: APXvYqyjjL7eqaRY2+s9bu95g0pdrYJ5J3Ic27LCEGfbUN72vqWkF/h2lAiwJgBam1hk+GkHmyRPPg==
X-Received: by 2002:a2e:9f44:: with SMTP id v4mr15550363ljk.72.1557198847442;
        Mon, 06 May 2019 20:14:07 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id n4sm2955760lfe.15.2019.05.06.20.14.06
        for <linux-spi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 20:14:06 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id z1so691152ljb.3
        for <linux-spi@vger.kernel.org>; Mon, 06 May 2019 20:14:06 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr85776ljh.22.1557198846159;
 Mon, 06 May 2019 20:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190506143301.GU14916@sirena.org.uk> <CAADWXX_MqtZ6RxS2zEVmHtKrjqigiNzdSe5qVwBVvfVU6dxJRQ@mail.gmail.com>
 <20190507021853.GY14916@sirena.org.uk> <20190507030241.GC14916@sirena.org.uk>
In-Reply-To: <20190507030241.GC14916@sirena.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 May 2019 20:13:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4EJQLoMNd4ptiiZvLy8ZW49pcCy0VQwZt4xhDDqSOjw@mail.gmail.com>
Message-ID: <CAHk-=wi4EJQLoMNd4ptiiZvLy8ZW49pcCy0VQwZt4xhDDqSOjw@mail.gmail.com>
Subject: Re: [GIT PULL] spi updates for v5.2
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Mon, May 6, 2019 at 8:02 PM Mark Brown <broonie@kernel.org> wrote:
>
>                    Everything I'm
> seeing is saying that Google just isn't enthusiastic about domains like
> kernel.org which is going an issue.

Well, there are other people who use kernel.org email addresses.  Ingo
Molnar, Rafael Wysocki, a couple of others.  But you're the one
getting marked as spam.

Somebody just hates you. I do end up checking my spam-box regularly,
so maybe it doesn't matter.

                 Linus
