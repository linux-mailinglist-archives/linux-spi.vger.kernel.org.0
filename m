Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 730C5204B1
	for <lists+linux-spi@lfdr.de>; Thu, 16 May 2019 13:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfEPL2t (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Thu, 16 May 2019 07:28:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36930 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbfEPL2s (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Thu, 16 May 2019 07:28:48 -0400
Received: by mail-lf1-f65.google.com with SMTP id q17so2361152lfo.4;
        Thu, 16 May 2019 04:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gEjnrderMD+qji8n1CYhJ0D2hXht6X9XySdj+hZW94M=;
        b=U0hLthwL7+2gRy5q0s51ncMxVgZCn0YB/oeY4lU5sUEEqrz1Al3Nvz+M1YdrEmgxtj
         UqhxKhjK7LBnWppGau3vUs7WYn+pXUtIub+VkjPAJOPW2TTsbIRSZXzpCk95rsm2gonQ
         s3C6CCfnF/DPGJqXi+C5hCcnqP6K8/JOWKEcTs37qFZjqhzFF5ryQF9/vC/ML2yBj5N7
         qYnOJGOR0Womg4/2suFy7VhPRdQhEiXfzQmYXKIY3Ax8mOs7IAhD4xhwEvc1vFEo4ugH
         8LtsewAqlhevcnERFBTNucLJ0uzcpoHdwEFV6fK4SoTUa9KqGNMiymLv7NnCouqNy5UT
         R6cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gEjnrderMD+qji8n1CYhJ0D2hXht6X9XySdj+hZW94M=;
        b=XTlhZ/DLdoMPVljo1peu0hp7WjbW6ln1qqolb1jvMTvmCtSmfpfFSUyyn+s4XVWOjv
         mmoPZZSQgqmiBYfpwbW0Z7okJneg4CQeiZleVxkHLHK9Golbf1I5SUd+wtzxmLIQf9ZY
         zyAVvxIiJq8xq+sF8yzwCCdVY/L7JZVyvf1Wq8Lo/KdBRPkbUqKPHnQKtjyLVku7dqtP
         2Fif2lfyqp/AWcH/uq1nodqRTFeu+HnX02gIWN3cCMATmFE+e5O5y3dNYTFZzqDwMS81
         SR0a+KaMdfrjsrj/UX9TWT4Fg8w+KYkdayD+wnWYGf3Zh4vDrVi+sK6cuOmeEao+X3bN
         UWgA==
X-Gm-Message-State: APjAAAXtN6F3YhLIZ6sUSoB8t2trvyJPabNpl9Hk0dPdHx1XLAoSuABH
        Kf7Ki6nRMOmzZd7PRxKaxs4CrANmd9GNAYiDlXFyc9EF
X-Google-Smtp-Source: APXvYqzZnEVBjcr0UUArd9Y/oHNPeVsZfHHba7EOXCtZd2u8f9QMTyL9WbJ198nWm+6fzBcph0vev4uy1X5N+aE9RX8=
X-Received: by 2002:ac2:5621:: with SMTP id b1mr24888584lff.27.1558006126907;
 Thu, 16 May 2019 04:28:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190516111450.6730-1-cniedermaier@dh-electronics.com>
In-Reply-To: <20190516111450.6730-1-cniedermaier@dh-electronics.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 16 May 2019 08:28:36 -0300
Message-ID: <CAOMZO5AVxwFWswCqJNaU1jo3iLc1UJZ52HvHvCHhzDU195WsFg@mail.gmail.com>
Subject: Re: [PATCH] spi: spidev: Add dhcom-board to compatibility list [Klartext]
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

Hi Christoph,

It seems that the [Klartext] string is added in the Subject by mistake?

On Thu, May 16, 2019 at 8:23 AM Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:
>
> Prepare to use devices on the external SPI interface
> on a DH electronics Development Board.
>
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
