Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40D51B2A85
	for <lists+linux-spi@lfdr.de>; Tue, 21 Apr 2020 16:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729003AbgDUOyK (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 21 Apr 2020 10:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgDUOyJ (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 21 Apr 2020 10:54:09 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C7CC061A10;
        Tue, 21 Apr 2020 07:54:09 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id i3so15242476ioo.13;
        Tue, 21 Apr 2020 07:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OFl1S/tYiqtxUGgdohewAoRDWreGte4tsL2N3e3cX84=;
        b=OsQM9ZGB/IqxAt1L/YT6rZ7UB0w5FG53W3kVJ4x8u1jQ7w12Dcb42keIEmWVHPXvg6
         PUrJNIbKReHMQgj3pOuOFHXLTlj+FPVQHhiFgAlZAEdxB1Oxck8NMJTlxw0EGXSXpk/y
         i/m9X+o/JLBO+znN4nT8+IwqWIjN8U3PpkslRbCnmCcjHxR39vCii9fS+j4Uxth0kFF0
         zW8Hv+rMSvdUKv7HT4pXJPpSfVS+lsEC76KJ25RBgqRyxKgpUnx4YCMsAaiQUPCJA94K
         tGc42tbhPv9NkOvrVYjtrLtc6lxmoYDC+xIYc1y1hCA+rlHtx0QAy19VbOLhKZOJbTTC
         Hi0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OFl1S/tYiqtxUGgdohewAoRDWreGte4tsL2N3e3cX84=;
        b=l+2nWr0SjbyT8aEDYBgrvnwJhPXwzEA8IJrJoU/VqDB6kNFewUh6/7OozriPI9X4Dl
         UtfehimdGNqjIayMXI3w665HdJm/0u/6D1SUmZ6i3PWC8Vylw/+jdx1NWfPSTGoFHvQC
         +W4SYaakwkd1/1SckKGyVj0T9BPanJREV6HUA2vzRYnhN9t5+yj1+cKHf81+PHsn0VAL
         ezSA/idE3szlLbfNJIiMIr3oOeUgzayegHkyDfEN3AiSD2nhpaN9MG9yM1IksJvbgjLr
         sKDk4eilQ758PJYJz9/WVOOU9Ge1tFpio7PVW57eCOK561zFQmu+0QX0SkPIoBLCIxpt
         EEzw==
X-Gm-Message-State: AGi0PuYSEt0SewVcZifEzo9HcEqZd2ufgLeE58X/02s8zQd6SKKLpnfH
        FZz+wYw8PfgYnxNYRDxomCUiNi4ApXyA+wILtPdX/ubZFe0=
X-Google-Smtp-Source: APiQypIYnPvx4CxNtWJIhi+2NRdaSJcvr6T4sYccdXzsw2X+GwnBukU95JeDtsyXsLHvkWqfoOIc+yraZ3iT61ED8xk=
X-Received: by 2002:a5d:8744:: with SMTP id k4mr21056611iol.62.1587480848719;
 Tue, 21 Apr 2020 07:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200420190853.45614-1-kdasu.kdev@gmail.com> <20200420190853.45614-10-kdasu.kdev@gmail.com>
 <20200421125025.GB4540@sirena.org.uk>
In-Reply-To: <20200421125025.GB4540@sirena.org.uk>
From:   Kamal Dasu <kdasu.kdev@gmail.com>
Date:   Tue, 21 Apr 2020 10:53:57 -0400
Message-ID: <CAC=U0a35yfnuXN1CXV7YnHCff-Ba+7UZ2dd0rFVFSNuA=O98VQ@mail.gmail.com>
Subject: Re: [Patch v3 9/9] spi: bcm-qspi: MSPI_SPCR0_MSB MSTR bit exists only
 on legacy controllers
To:     Mark Brown <broonie@kernel.org>
Cc:     bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Apr 21, 2020 at 8:50 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Apr 20, 2020 at 03:08:53PM -0400, Kamal Dasu wrote:
> > Set MASTER bit on the MSPI_SPCR0_MSB only for legacy MSPI and HIF_MSPI
> > controllers.
> >
> > Fixes: fa236a7ef240 ("spi: bcm-qspi: Add Broadcom MSPI driver")
> > Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
>
> If this is a fix it should have been near the start of the series before
> any new features to make sure that it can be applied cleanly as a fix.

Yes it could can be after [Patch v3 3/9] spi: bcm-qspi: Handle lack of
MSPI_REV offset

Kamal
