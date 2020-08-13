Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4F7243CE7
	for <lists+linux-spi@lfdr.de>; Thu, 13 Aug 2020 17:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726252AbgHMP7a (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 13 Aug 2020 11:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgHMP7a (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 13 Aug 2020 11:59:30 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256A4C061757
        for <linux-spi@vger.kernel.org>; Thu, 13 Aug 2020 08:59:30 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id p8so3147139vsm.12
        for <linux-spi@vger.kernel.org>; Thu, 13 Aug 2020 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ToE95yFkuJhD4LD7ZDsJJykke8b8cCnsh7HC0yrzVq0=;
        b=EEVe7i8DrCVVzJaF3Zex7DHYzufzyLgvP5iWqHgoTM65sOkvVC9eBrR6mSqXygjOPK
         xn0HjxoVi54oIqP0yYiwVCDNHwmUQ7OqUniLOtmdIPC73eHsXgBTD6rh+vPycVbRZ6Ul
         qF8ThooAFVWr3BMZYIDoxcEPX9CPAcL983wcXnBWcFtaMod+4ahcGtjBSni0/3uA7tay
         jk2yAnEG4ouDOsyPi56D/YCmoykHdANCgqy1u4XOsX9NuLRO5rqtnodsphcOKjrJNJDa
         Ot5IxYiENFDszGWxMiRMva897+ecSxRa2B2UP+AGa0e675K5c6IsZzOuGts7Ci21bvqU
         2iDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=ToE95yFkuJhD4LD7ZDsJJykke8b8cCnsh7HC0yrzVq0=;
        b=XNwVcdls2mF7CG1PoZJCgAeZg5b1lx9TQYg7hUn2OKO4mqnN1zVsOyC5/0ninSxfEv
         ekEL0so7wM+dsEHWORWxck3FP8B5uulQSPg4qQoQERhwVXIo4YayZTMNisehLCF2f/3Y
         qvDOoJO2wXAtIqI++cbkWsUXsLDsTo6eXwGNe2LfkuPvSgggCrK/gEHr357Kd1NIO1wh
         SjuEQ0ALYOcT6hDa1Mr/C51PF1UVwVLsrhb7HFVbgdxgQuLMa8HvCuy1DdHZIDh9yUPX
         Mswx5bisRvAas7LWNDizL7N5wJxxD4m+gQLF58e8yyRpbVQBRslGkZfbyA0ESVUrMlxX
         sLTA==
X-Gm-Message-State: AOAM531v6oW1OE2gx5z4HPfhQRo+XRggVAN4Qyk7oGVG1gSnElu29khF
        BAGVOQLMVUPaDDI4yqqBJSGIfE8rzwvHz4TVX9iXZQ==
X-Google-Smtp-Source: ABdhPJxDqTRNz8HDlhO0DhSAkFEoox7QZDtZ/jQ0g/8ku4sXmiOI18qR0iUALzyRqOUNHn+V+Lji0MsVRI1XZMbKC7Y=
X-Received: by 2002:a67:ffd8:: with SMTP id w24mr3618123vsq.148.1597334368773;
 Thu, 13 Aug 2020 08:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAD-cv=NLFXSmhvc3HPCRY-_SkCn-2+6-i+k=-jOzs59Sd1uepQ@mail.gmail.com>
 <CAD-cv=P5TxgVOxDFJCafb=B+Tj3ABRheyuU93hfi6cw9TxXxvQ@mail.gmail.com>
In-Reply-To: <CAD-cv=P5TxgVOxDFJCafb=B+Tj3ABRheyuU93hfi6cw9TxXxvQ@mail.gmail.com>
From:   Andrea Tessadri <tessadriandrea@gmail.com>
Date:   Thu, 13 Aug 2020 17:59:17 +0200
Message-ID: <CAD-cv=PVEf82VA0pnVLz_p9ukkvYDp3AnGKeJWybos1tHsL3Jg@mail.gmail.com>
Subject: Fwd: SPI for IMX6x with cyclic DMA for continuous transfer
To:     linux-spi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

I've just developed and tested cyclic DMA transfer for a SPI device on
a IMX6UL with kernel 4.9.88
I wanted to have a single SPI transfer repeated continuously in order
to feed a DAC for generation of a particular waveform for a medical
device, without interruption and minimal jitter (this is why I though
to make the change at low level, instead of making the protocol driver
to pump several identical messages to SPI subsystem)
I am wondering if this feature could be interesting for other
applications and if it is worth to submit a patch for
drivers/spi/spi-imx.c
Thank you in advance

  Andrea
