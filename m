Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7FB22A06F
	for <lists+linux-spi@lfdr.de>; Wed, 22 Jul 2020 22:02:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgGVUC7 (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Wed, 22 Jul 2020 16:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVUC6 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Wed, 22 Jul 2020 16:02:58 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1559C0619DC;
        Wed, 22 Jul 2020 13:02:58 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id n5so1867687pgf.7;
        Wed, 22 Jul 2020 13:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8TVQ7HTR8nifrCWHMhxbEqy5HUNl692zo6KwqDMUDFg=;
        b=aaUhQwdpSSqQAOd8p+RQ6hjlLiXsro6kTfFRenpOHNUr54L83Cn2lKYvx2pRrJDvz2
         PxXF7upKVpZHr1oO1sPSw3fO43vqI2XTrjWBZq1BRtizqK3Xbd3MWZIcq4FZLbWz9faJ
         Guxda7heJJ5HJVvH79ZBIloLMatu5ulxpAKLjzV2ifVoaw9xWA3ays3lr4thSkfOgkmP
         xCoInG6+I71AKonlaWkmoOShsDIb+564rm3ADis4h/8hav6RXGU/3qusOiNhBIL7QDtz
         b7NIlfnOfW0OwtX7MeZuHGjnGvS3x91oe9radk3OVPuwcmV2Jjm5k9737YyqF070ifWw
         vLCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8TVQ7HTR8nifrCWHMhxbEqy5HUNl692zo6KwqDMUDFg=;
        b=Hzd+Dlj016Tj9BtMuzKY+pH1Zu3IKoNDuY55M641hdl18YVlfHP5/dfSOXp0d6jadt
         pyyIKw/gCXzjACSfba/LqLj+dLonf7cOa5LjVLgEzYI7xZIUbjgZwgBVjtFxgOM6aMSX
         00n0ZSSeIt4ZdwQ8GV17XuBES8hywHJUZumf1PdCJZQ00HBWAE8CNG5biSDpUR3dg7Ca
         ybJ28mgM7aj1/Rs7eFzbUTRuLaObQt1tYcrg0v35+4+8/jeOx2O652+oIkynnPZ3iwvq
         /bQC5U0Ek5Ovsf3DEjzeHh6gnsm0Ctl3kEfWg0wA1hqjwD6euBzi4tjOFhT2lT5PTZcy
         ytXw==
X-Gm-Message-State: AOAM532ajLw2AvLDUPruCaYy8rjV7Pg8bdGu+F9GqzPuM5xUayzW8coK
        S//UeiSynl2FtW0toG26SHg=
X-Google-Smtp-Source: ABdhPJx+nD2Z4T0ULOHNz5iOvh4C/4EGxLKGNQcm83/T4FTLUSIEIG20sO3SvYGvakj67hBBPM0yVA==
X-Received: by 2002:a63:cb05:: with SMTP id p5mr1359392pgg.120.1595448178313;
        Wed, 22 Jul 2020 13:02:58 -0700 (PDT)
Received: from gmail.com ([103.105.153.67])
        by smtp.gmail.com with ESMTPSA id y7sm421071pgk.93.2020.07.22.13.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 13:02:57 -0700 (PDT)
Date:   Thu, 23 Jul 2020 01:31:34 +0530
From:   Vaibhav Gupta <vaibhavgupta40@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] spi: spi-topcliff-pch: use generic power management
Message-ID: <20200722200134.GA4310@gmail.com>
References: <20200720155714.714114-1-vaibhavgupta40@gmail.com>
 <159542550175.19884.5724047291778558359.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <159542550175.19884.5724047291778558359.b4-ty@kernel.org>
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Wed, Jul 22, 2020 at 02:45:17PM +0100, Mark Brown wrote:
> On Mon, 20 Jul 2020 21:27:15 +0530, Vaibhav Gupta wrote:
> > Drivers using legacy PM have to manage PCI states and device's PM states
> > themselves. They also need to take care of configuration registers.
> > 
> > With improved and powerful support of generic PM, PCI Core takes care of
> > above mentioned, device-independent, jobs.
> > 
> > This driver makes use of PCI helper functions like
> > pci_save/restore_state(), pci_enable/disable_device(), pci_enable_wake()
> > and pci_set_power_state() to do required operations. In generic mode, they
> > are no longer needed.
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
> 
> Thanks!
> 
> [1/1] spi: spi-topcliff-pch: use generic power management
>       commit: f185bcc779808df5d31bc332b79b5f1455ee910b
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
Thanks,
--Vaibhav Gupta
> 
> Thanks,
> Mark
