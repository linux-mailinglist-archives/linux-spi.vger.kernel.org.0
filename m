Return-Path: <linux-spi-owner@vger.kernel.org>
X-Original-To: lists+linux-spi@lfdr.de
Delivered-To: lists+linux-spi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D81285D5A5
	for <lists+linux-spi@lfdr.de>; Tue,  2 Jul 2019 19:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726686AbfGBRvJ (ORCPT <rfc822;lists+linux-spi@lfdr.de>);
        Tue, 2 Jul 2019 13:51:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33153 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfGBRvI (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Tue, 2 Jul 2019 13:51:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id m4so8052242pgk.0
        for <linux-spi@vger.kernel.org>; Tue, 02 Jul 2019 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6c1bABhNAfFqqcqeosnnC+OxaYU9EX7lfVatAKGkYfk=;
        b=SnKf+xx5/8zxMVJ01OSR5jKZ+4C7bL0AMI/7TDGUbVw9rqn0HiJ2FsOMS5iJgNO51j
         fjb9ULg73n5LC8UYFyGquLRaxk1rTFW+EBeLGgrlqW81By1RtCV+oaoAZZVeCo8k1k0/
         5YiO6V12vlnRz8o0KWkcdkH6YnxkWApi5kW6oytHtvUxxDqtiFO57JCxfmQqaTtw6Tvc
         lL38xqOxgmwZLdq5Fj/t5jeme5PkA0/al6w6I1Q/OdhX+4LvaUJaVXBCcRw3qEskLTxj
         jILpJ27gUv7S7XRPGKHVibg3JZDPfBSn09p4rhGLTq2Rlf20k6IhVCpDJ4i+IZHnXI7V
         WlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6c1bABhNAfFqqcqeosnnC+OxaYU9EX7lfVatAKGkYfk=;
        b=RgyVN3rRrRktBz0AG5EOYhOmPZw2SswNF65IV/kqaJ+kjMeEwD53xHYs0z4dQIKyD3
         NLXyjKweaBXRhYj5Wq8eoW9ukCHRPoBK5wZCV5/ruGlLEpNPAaB+bKjHjfMKmg3jea1k
         svEQ6tl+MYPP7jCEAZ40xsUvolB0sr2XzpU43s/NxpESpTIC5qIwW6NILy4RNXCMjBfl
         PW6OOqkA5sBRJVOOg6CsTUmoZ+K2rjzG715OFOo07DQw2f4yHgE3DMoMF3vfrNDfVv55
         JqqZpJvuSqQudCrVB9CqaaW7yaGxxk49HsGxwtqEXJBo4aOlEVPMN/3rFKS17gojPcZs
         puYg==
X-Gm-Message-State: APjAAAUsAH+1YUHmSxYHFKFMm+iFLBvd1qnbOgmFBBktQICUFpmSD1JE
        iFQBBicRPo9BigIJjNxMcbT2xeIHkPrmEi5MA/8=
X-Google-Smtp-Source: APXvYqy0jtI25bJsHAA7TuvKeZTn6Mk0Dt2GzIYMG3pInZ8RoVpSz6GjzlG6SfN4FGzwXDON6j/dRMxpPICCjURt2I4=
X-Received: by 2002:a63:6eca:: with SMTP id j193mr13446820pgc.74.1562089868140;
 Tue, 02 Jul 2019 10:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <201906042339.gt5sS7Hb%lkp@intel.com>
In-Reply-To: <201906042339.gt5sS7Hb%lkp@intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 2 Jul 2019 20:50:56 +0300
Message-ID: <CAHp75VcqTvoSf3-vbH555iY9NNu+fd5bzL0TFxfZEVU3M=Pg2Q@mail.gmail.com>
Subject: Re: [spi:for-5.3 41/41] drivers/spi/spi-synquacer.c:153:3: error:
 implicit declaration of function 'readsb'; did you mean 'readb'?
To:     kbuild test robot <lkp@intel.com>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>, kbuild-all@01.org,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-spi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org

On Tue, Jun 4, 2019 at 6:59 PM kbuild test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.3
> head:   b0823ee35cf9bc6b9a5403c12f12bd3e0b490045
> commit: b0823ee35cf9bc6b9a5403c12f12bd3e0b490045 [41/41] spi: Add spi driver for Socionext SynQuacer platform
> config: alpha-allyesconfig (attached as .config)
> compiler: alpha-linux-gcc (GCC) 7.4.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout b0823ee35cf9bc6b9a5403c12f12bd3e0b490045
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.4.0 make.cross ARCH=alpha
>

It seems false positive.
kbuild bot has to be fixed,

> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    drivers/spi/spi-synquacer.c: In function 'read_fifo':
> >> drivers/spi/spi-synquacer.c:153:3: error: implicit declaration of function 'readsb'; did you mean 'readb'? [-Werror=implicit-function-declaration]
>       readsb(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
>       ^~~~~~
>       readb
> >> drivers/spi/spi-synquacer.c:160:3: error: implicit declaration of function 'readsw'; did you mean 'readw'? [-Werror=implicit-function-declaration]
>       readsw(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
>       ^~~~~~
>       readw
> >> drivers/spi/spi-synquacer.c:169:3: error: implicit declaration of function 'readsl'; did you mean 'readl'? [-Werror=implicit-function-declaration]
>       readsl(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
>       ^~~~~~
>       readl
>    drivers/spi/spi-synquacer.c: In function 'write_fifo':
> >> drivers/spi/spi-synquacer.c:194:3: error: implicit declaration of function 'writesb'; did you mean 'writeb'? [-Werror=implicit-function-declaration]
>       writesb(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
>       ^~~~~~~
>       writeb
> >> drivers/spi/spi-synquacer.c:201:3: error: implicit declaration of function 'writesw'; did you mean 'writew'? [-Werror=implicit-function-declaration]
>       writesw(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
>       ^~~~~~~
>       writew
> >> drivers/spi/spi-synquacer.c:210:3: error: implicit declaration of function 'writesl'; did you mean 'writel'? [-Werror=implicit-function-declaration]
>       writesl(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
>       ^~~~~~~
>       writel
>    cc1: some warnings being treated as errors
>
> vim +153 drivers/spi/spi-synquacer.c
>
>    140
>    141  static int read_fifo(struct synquacer_spi *sspi)
>    142  {
>    143          u32 len = readl(sspi->regs + SYNQUACER_HSSPI_REG_DMSTATUS);
>    144
>    145          len = (len >> SYNQUACER_HSSPI_DMSTATUS_RX_DATA_SHIFT) &
>    146                 SYNQUACER_HSSPI_DMSTATUS_RX_DATA_MASK;
>    147          len = min(len, sspi->rx_words);
>    148
>    149          switch (sspi->bpw) {
>    150          case 8: {
>    151                  u8 *buf = sspi->rx_buf;
>    152
>  > 153                  readsb(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
>    154                  sspi->rx_buf = buf + len;
>    155                  break;
>    156          }
>    157          case 16: {
>    158                  u16 *buf = sspi->rx_buf;
>    159
>  > 160                  readsw(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
>    161                  sspi->rx_buf = buf + len;
>    162                  break;
>    163          }
>    164          case 24:
>    165                  /* fallthrough, should use 32-bits access */
>    166          case 32: {
>    167                  u32 *buf = sspi->rx_buf;
>    168
>  > 169                  readsl(sspi->regs + SYNQUACER_HSSPI_REG_RX_FIFO, buf, len);
>    170                  sspi->rx_buf = buf + len;
>    171                  break;
>    172          }
>    173          default:
>    174                  return -EINVAL;
>    175          }
>    176
>    177          sspi->rx_words -= len;
>    178          return 0;
>    179  }
>    180
>    181  static int write_fifo(struct synquacer_spi *sspi)
>    182  {
>    183          u32 len = readl(sspi->regs + SYNQUACER_HSSPI_REG_DMSTATUS);
>    184
>    185          len = (len >> SYNQUACER_HSSPI_DMSTATUS_TX_DATA_SHIFT) &
>    186                 SYNQUACER_HSSPI_DMSTATUS_TX_DATA_MASK;
>    187          len = min(SYNQUACER_HSSPI_FIFO_DEPTH - len,
>    188                      sspi->tx_words);
>    189
>    190          switch (sspi->bpw) {
>    191          case 8: {
>    192                  const u8 *buf = sspi->tx_buf;
>    193
>  > 194                  writesb(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
>    195                  sspi->tx_buf = buf + len;
>    196                  break;
>    197          }
>    198          case 16: {
>    199                  const u16 *buf = sspi->tx_buf;
>    200
>  > 201                  writesw(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
>    202                  sspi->tx_buf = buf + len;
>    203                  break;
>    204          }
>    205          case 24:
>    206                  /* fallthrough, should use 32-bits access */
>    207          case 32: {
>    208                  const u32 *buf = sspi->tx_buf;
>    209
>  > 210                  writesl(sspi->regs + SYNQUACER_HSSPI_REG_TX_FIFO, buf, len);
>    211                  sspi->tx_buf = buf + len;
>    212                  break;
>    213          }
>    214          default:
>    215                  return -EINVAL;
>    216          }
>    217
>    218          sspi->tx_words -= len;
>    219          return 0;
>    220  }
>    221
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
With Best Regards,
Andy Shevchenko
