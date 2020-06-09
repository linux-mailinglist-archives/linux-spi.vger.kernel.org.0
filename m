Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783F41F3557
	for <lists+linux-spi@lfdr.de>; Tue,  9 Jun 2020 09:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgFIHq6 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 9 Jun 2020 03:46:58 -0400
Received: from mail-oo1-f67.google.com ([209.85.161.67]:42973 "EHLO
        mail-oo1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgFIHq5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 9 Jun 2020 03:46:57 -0400
Received: by mail-oo1-f67.google.com with SMTP id h7so3989297ooc.9
        for <linux-spi@vger.kernel.org>; Tue, 09 Jun 2020 00:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tPX2pvlrZL9rqjxGuDCfvVDItAZwm6AGdY70GZcJB2w=;
        b=kvMEAWYKvW0flbUwO3M88d/kdFz3XifSd7L8RrGAOh1WWxadaTtSvRwtDYYYNFsEEP
         EDOwd5d/ichKget/VaAhNlppaNqRI2BWFeJjp1eVNeo5rfRzIYHQ4057bDmWCNzO4Sye
         M5mvd+4ZWERHzjPQpc7EtBRDa+0f42upNUSoFsYFoHQVW0BQc4wYwlcQ9XBzfrZaVx66
         QmDDHKygP72tndZziR+kKr+VqTn+PcjYq3BSE/16G7Rd3KsqKp44m1KCwiHH/7Xqr0CN
         IYcqSqyyY/XjuFANCP9qJbYE5W1BS/QJ6VeaEU/R//Rwkylz50L61hFpU6QIOxmu+0y6
         JZiA==
X-Gm-Message-State: AOAM530PsJYnmWQCL00KXscX7VK/yS9TFfhv+mS2Cp7x2ov/asCiY6ZQ
        nG5NjomRI8786K+bJER+NDDmwMrj8qg1gyeUSZE8cK2d
X-Google-Smtp-Source: ABdhPJyIM8//fCgaOLeUNDKDtE6YgM3TWcKB9QKN/somlTrNDTZfVXgGK9ScQqLEoZx3twEbzpMivQqtsDlDfMsBzeo=
X-Received: by 2002:a4a:5744:: with SMTP id u65mr20020188ooa.1.1591688816845;
 Tue, 09 Jun 2020 00:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <4958d1437f88e47e57b9736b0c0fc067ece812f1.camel@infinera.com>
In-Reply-To: <4958d1437f88e47e57b9736b0c0fc067ece812f1.camel@infinera.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 9 Jun 2020 09:46:44 +0200
Message-ID: <CAMuHMdW_0QhS8SOh9EKFgMynDV7pdYg3CTX0EDN83+MTE8m-Aw@mail.gmail.com>
Subject: Re: Linux as a SPI slave?
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Jocke,

On Tue, Jun 2, 2020 at 6:38 PM Joakim Tjernlund
<Joakim.Tjernlund@infinera.com> wrote:
> From what I can tell, the wast uses of SPI in Linux is as an SPI master. Is there
> any use cases as a SPI slave?

It's out there:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/spi/Kconfig#n976

> I fear that the latency can make Linux unsuitable as a SPI slave, has anybody tried?

Please check my FOSDEM presentation for limitations:
https://archive.fosdem.org/2018/schedule/event/hwenablement_linux_as_spi_slave/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
